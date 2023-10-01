part of 'radio_stations_cubit.dart';

@immutable
abstract class RadioStationsState {}

class RadioStationsLoading extends RadioStationsState {}

class RadioStationsLoaded extends RadioStationsState {
  final List<RadioStations> stations;

  RadioStationsLoaded(this.stations);
}

class RadioStationsError extends RadioStationsState {
  final String message;

  RadioStationsError(this.message);
}
