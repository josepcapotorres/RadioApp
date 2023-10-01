import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_player/features/streaming/data/models/radio_station.dart';

import '../data/repositories/radio_stations_repository.dart';

part 'radio_stations_state.dart';

class RadioStationsCubit extends Cubit<RadioStationsState> {
  final RadioStationsRepository _repository;

  RadioStationsCubit(this._repository) : super(RadioStationsLoading());

  void getRadioStations() async {
    emit(RadioStationsLoading());

    final stationsResult = await _repository.fetchRadioStations();

    stationsResult.fold(
      (l) => emit(RadioStationsError(l.message)),
      (r) => emit(RadioStationsLoaded(r)),
    );
  }
}
