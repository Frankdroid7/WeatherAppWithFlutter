import 'package:flutter/foundation.dart';

class WeatherModelList {
  final String weatherMoment;
  final List<String> weatherTime;
  final List<String> weatherIcon;
  final List<int> weatherTemp;
  final List<int> weatherHumidity;
  final int weatherDetailsLength;

  WeatherModelList({
    @required this.weatherMoment,
    @required this.weatherTime,
    @required this.weatherIcon,
    @required this.weatherTemp,
    @required this.weatherHumidity,
    @required this.weatherDetailsLength,
  });
}
