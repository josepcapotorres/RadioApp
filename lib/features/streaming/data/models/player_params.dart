class PlayerParams {
  final bool isPlaying;
  final double volume;

  PlayerParams({
    required this.isPlaying,
    required this.volume,
  });

  PlayerParams copyWith({bool? isPlaying, double? volume}) {
    return PlayerParams(
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
    );
  }
}
