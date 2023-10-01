import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';

import '../../features/streaming/data/models/models.dart';

final _flutterRadioPlayer = FlutterRadioPlayer();
late FRPSource _radioSource;

void stopStreaming() {
  _flutterRadioPlayer.stop();
}

void generateMediaSources(List<RadioStations> stations, int index) {
  _radioSource = FRPSource(
    mediaSources: stations
        .map(
          (e) => MediaSources(
            isPrimary: stations.indexOf(e) == index,
            url: e.urlResolved,
            description: e.name,
            isAac: e.urlResolved.endsWith("mp3"),
          ),
        )
        .toList(),
  );
}

void initData() {
  _flutterRadioPlayer.initPlayer();
  _flutterRadioPlayer.addMediaSources(_radioSource);
  _flutterRadioPlayer.useIcyData(true);
}

void playOrPause() {
  _flutterRadioPlayer.playOrPause();
}

void play() {
  _flutterRadioPlayer.play();
}

void pause() {
  _flutterRadioPlayer.pause();
}

void setVolume(double volume) {
  _flutterRadioPlayer.setVolume(volume);
}

Stream<String?>? getEventStream() {
  return _flutterRadioPlayer.frpEventStream;
}
