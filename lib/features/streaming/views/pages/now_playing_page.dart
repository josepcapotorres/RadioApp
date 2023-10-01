import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_player/core/plugins/streaming.dart' as streaming;
import 'package:radio_player/features/streaming/bloc/controls/controls_cubit.dart';
import 'package:radio_player/features/streaming/bloc/radio_stations_cubit.dart';

import '../../data/models/models.dart';
import '../widgets/widgets.dart';

class NowPlayingPage extends StatelessWidget {
  static const routeName = "now_playing";

  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controlsCubit = context.read<ControlsCubit>();

    return WillPopScope(
      onWillPop: () async {
        // It ensures that the streaming is going to be stopped if we
        // navigate back and the streaming is still playing
        if (controlsCubit.isPlaying) {
          streaming.stopStreaming();
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Now playing"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: BlocBuilder<RadioStationsCubit, RadioStationsState>(
              builder: (_, state) {
                if (state is RadioStationsLoading) {
                  Future.microtask(() {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator.adaptive(),
                              SizedBox(height: 15),
                              Text("Cargando..."),
                            ],
                          ),
                        );
                      },
                    );
                  });

                  return const SizedBox();
                } else if (state is RadioStationsLoaded) {
                  final selectedIndex =
                      ModalRoute.of(context)?.settings.arguments as int?;

                  if (selectedIndex == null) {
                    return const Center(
                      child: Text("Emisora no encontrada"),
                    );
                  }

                  return _Body(state.stations, selectedIndex);
                } else if (state is RadioStationsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Estado desconocido"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<RadioStations> stations;
  final int index;

  const _Body(
    this.stations,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.repeat(); // Start of the rotation by default
  }

  @override
  Widget build(BuildContext context) {
    final controlsCubit = context.watch<ControlsCubit>();

    streaming.generateMediaSources(
      widget.stations,
      widget.index,
    );

    streaming.initData();

    // It starts the reproduction of the sound when the screen is loaded
    streaming.playOrPause();

    final currentStation = widget.stations[widget.index];

    return Column(
      children: [
        const SizedBox(width: double.infinity),
        TurningImage(
          stationName: currentStation.name,
          imageUrl: currentStation.favicon,
          controller: _controller,
        ),
        const SizedBox(height: 30),
        Text(
          currentStation.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(currentStation.homepage),
        const SizedBox(height: 30),
        Row(
          children: [
            const Icon(
              Icons.volume_down,
              size: 40,
            ),
            Expanded(
              child: Slider(
                value: controlsCubit.state.volume,
                divisions: 10,
                onChanged: (val) {
                  controlsCubit.setVolume(val);
                  streaming.setVolume(val);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const _RadioControlButtons(),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _RadioControlButtons extends StatefulWidget {
  const _RadioControlButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<_RadioControlButtons> createState() => _RadioControlButtonsState();
}

class _RadioControlButtonsState extends State<_RadioControlButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _iconsSize = 60.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streaming.getEventStream(),
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // The plugin crashes with this line
                // widget.flutterRadioPlayer.previous();
              },
              child: Icon(Icons.skip_previous, size: _iconsSize),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: _onPlayPausePressed,
              child: AnimatedIcon(
                icon: AnimatedIcons.pause_play,
                size: _iconsSize,
                progress: _animationController,
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                // The plugin crashes with this line
                //widget.flutterRadioPlayer.next();
              },
              child: Icon(Icons.skip_next, size: _iconsSize),
            ),
          ],
        );
      },
    );
  }

  void _onPlayPausePressed() {
    final controlsCubit = context.read<ControlsCubit>();

    controlsCubit.setIsPlaying(
      !controlsCubit.isPlaying,
    );

    if (controlsCubit.state.isPlaying) {
      streaming.pause();
    } else {
      streaming.play();
    }

    controlsCubit.isPlaying
        ? _animationController.reverse()
        : _animationController.forward();
  }
}
