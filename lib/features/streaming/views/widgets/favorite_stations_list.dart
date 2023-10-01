import 'package:flutter/material.dart';
import 'package:radio_player/features/streaming/data/models/radio_station.dart';

class FavoriteStationsList extends StatelessWidget {
  const FavoriteStationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    /*return ListView(
      scrollDirection: Axis.horizontal,
      children: radioResults
          .where((e) => e.favorite)
          .map((e) => _FavoriteStationsListItem(e))
          .toList(),
    );*/
  }
}

class _FavoriteStationsListItem extends StatelessWidget {
  final RadioStations station;

  const _FavoriteStationsListItem(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 100,
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 80,
              width: 80,
              color: Colors.white,
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(station.favicon),
                placeholder: AssetImage("assets/loading.gif"),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(station.name),
        ],
      ),
    );
  }
}
