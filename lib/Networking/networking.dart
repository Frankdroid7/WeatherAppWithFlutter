import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Constants/constants.dart';

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    var data = await http.get(url);

    if (data.statusCode == 200) {
      print('cool: ${data.statusCode}');
      var jsonBody = data.body;
      return jsonDecode(jsonBody);
    } else {
      print('something went wrong: ${data.statusCode}');
    }
  }
}
