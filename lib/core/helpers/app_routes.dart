import 'package:flutter/material.dart';
import 'package:radio_player/features/streaming/views/pages/pages.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return {
    RadioStationsPage.routeName: (_) => const RadioStationsPage(),
    NowPlayingPage.routeName: (_) => const NowPlayingPage(),
  };
}
