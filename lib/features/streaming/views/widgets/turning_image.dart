import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_player/features/streaming/bloc/controls/controls_cubit.dart';
import 'package:radio_player/features/streaming/views/widgets/widgets.dart';

class TurningImage extends StatelessWidget {
  final String imageUrl;
  final AnimationController controller;
  final String stationName;

  const TurningImage({
    Key? key,
    required this.imageUrl,
    required this.stationName,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPlaying = context.watch<ControlsCubit>().isPlaying;

    return RotationTransition(
      turns: isPlaying
          ? Tween(begin: 0.0, end: 1.0).animate(controller)
          : const AlwaysStoppedAnimation(0.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              height: 160,
              width: 160,
              child: FadeInNetworkImage(
                urlImage: imageUrl,
                stationName: stationName,
              ),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
