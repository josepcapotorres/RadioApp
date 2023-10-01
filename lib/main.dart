import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_player/core/helpers/app_colors.dart';
import 'package:radio_player/features/streaming/bloc/controls/controls_cubit.dart';
import 'package:radio_player/features/streaming/bloc/radio_stations_cubit.dart';
import 'package:radio_player/features/streaming/data/repositories/radio_stations_repository_impl.dart';

import 'core/helpers/app_routes.dart';
import 'features/streaming/views/pages/pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RadioStationsCubit>(
          create: (_) => RadioStationsCubit(
            RadioStationsRepositoryImpl(),
          ),
        ),
        BlocProvider<ControlsCubit>(create: (_) => ControlsCubit()),
      ],
      child: MaterialApp(
        title: "Radio streaming",
        initialRoute: RadioStationsPage.routeName,
        routes: getApplicationRoutes(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
          ),
          appBarTheme: AppBarTheme(color: primaryColor),
        ),
      ),
    );
  }
}
