import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_player/features/streaming/bloc/radio_stations_cubit.dart';
import 'package:radio_player/features/streaming/data/models/radio_station.dart';
import 'package:radio_player/features/streaming/views/widgets/widgets.dart';

import '../pages/pages.dart';

class StationsList extends StatelessWidget {
  const StationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radioStationsCubit = context.read<RadioStationsCubit>();

    radioStationsCubit.getRadioStations();

    return BlocBuilder<RadioStationsCubit, RadioStationsState>(
      builder: (context, state) {
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
          // It dismisses the loading popup
          Future.microtask(() => Navigator.pop(context));

          return ListView.builder(
            itemBuilder: (_, i) {
              return SlideInLeft(
                delay: Duration(milliseconds: i * 60),
                from: 300,
                child: _StationsListItem(
                  state.stations[i],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NowPlayingPage.routeName,
                      arguments: i,
                    );
                  },
                ),
              );
            },
          );
        } else if (state is RadioStationsError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Estado desconocido"));
        }
      },
    );
  }
}

class _StationsListItem extends StatelessWidget {
  final VoidCallback onTap;
  final RadioStations station;

  const _StationsListItem(
    this.station, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = 70.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF98F1C),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: iconSize,
                width: iconSize,
                color: Colors.white,
                child: FadeInNetworkImage(
                  stationName: station.name,
                  urlImage: station.favicon,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    station.urlResolved,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Icon(Icons.heart_broken),
              ],
            )
          ],
        ),
      ),
    );
  }
}
