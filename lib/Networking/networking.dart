import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Model/WeatherModel.dart';

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future<dynamic> getData() async {
    var data = await http.get(url);

    if (data.statusCode == 200) {
      var jsonBody = data.body;
      // WeatherModel2.fromJson(jsonDecode(jsonBody));
      return jsonDecode(jsonBody);
    } else {
      print('Something went wrong: ${data.statusCode}');
    }
  }
}
