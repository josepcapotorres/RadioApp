import 'package:dartz/dartz.dart';
import 'package:radio_player/core/failures/failure.dart';
import 'package:radio_player/features/streaming/data/models/radio_station.dart';

abstract class RadioStationsRepository {
  Future<Either<Failure, List<RadioStations>>> fetchRadioStations();
}
