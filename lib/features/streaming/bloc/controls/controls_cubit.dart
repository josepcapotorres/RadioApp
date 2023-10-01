import 'package:bloc/bloc.dart';
import 'package:radio_player/features/streaming/data/models/player_params.dart';

class ControlsCubit extends Cubit<PlayerParams> {
  ControlsCubit()
      : super(PlayerParams(
          isPlaying: true,
          volume: 0.5,
        ));

  bool get isPlaying => state.isPlaying;

  void setIsPlaying(bool isPlaying) {
    final newValue = state.copyWith(isPlaying: isPlaying);

    emit(newValue);
  }

  void setVolume(double volume) {
    final newValue = state.copyWith(volume: volume);

    emit(newValue);
  }
}
