import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:radio_player/core/failures/failure.dart';
import 'package:radio_player/features/streaming/data/models/radio_station.dart';
import 'package:radio_player/features/streaming/data/repositories/radio_stations_repository.dart';

class RadioStationsRepositoryImpl implements RadioStationsRepository {
  final _baseUrl = "https://de1.api.radio-browser.info/json";

  @override
  Future<Either<Failure, List<RadioStations>>> fetchRadioStations() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stations/search?country=Spain"),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as List;

      final results =
          responseBody.map((e) => RadioStations.fromJson(e)).toList();

      return Right(results);
    } else {
      return Left(Failure("Error al intentar recuperar la lista de emisoras"));
    }
  }
}
