import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Weather/weather_data.dart';

import 'UI/NoInternetConnectionWidget.dart';
import 'UI/SignInWidget.dart';
import 'UI/WeatherHomePage.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

SharedPreferences localStorage;

class _WeatherAppState extends State<WeatherApp> {
  getSharedPreference() async {
    localStorage = await SharedPreferences.getInstance();
  }

  var subscription = Connectivity().onConnectivityChanged;

  Widget homeWidget;

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.listen((event) {}).cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff21335C),
      ),
      home: Scaffold(
        body: StreamBuilder<ConnectivityResult>(
            stream: subscription,
            builder: (context, snapshot) {
              if (!(snapshot.hasData)) {
                homeWidget = CircularProgressIndicator();
              }
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                homeWidget = SignInWidget();
              } else {
                homeWidget = NoInternetConnectionWidget();
              }
              return homeWidget;
            }),
      ),
    );
  }
}
