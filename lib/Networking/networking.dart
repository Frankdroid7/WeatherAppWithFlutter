import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future<dynamic> getData() async {
    var data = await http.get(url);

    if (data.statusCode == 200) {
      var jsonBody = data.body;
      return jsonDecode(jsonBody);
    } else {
      print('Something went wrong: ${data.statusCode}');
    }
  }
}
