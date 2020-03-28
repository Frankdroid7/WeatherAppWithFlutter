import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/WeatherHomePage.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff21335C),
      ),
      home: WeatherHomePage(),
    );
  }
}
