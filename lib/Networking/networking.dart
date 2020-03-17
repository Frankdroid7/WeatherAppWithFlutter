import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future<dynamic> getData() async {
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
