import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_data.dart';

import 'WeatherHomePage.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var subscription = Connectivity().onConnectivityChanged;

  Widget homeWidget;

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
              if (snapshot.data == ConnectivityResult.mobile || snapshot.data == ConnectivityResult.wifi) {
                homeWidget = HomeWidget();
              } else {
                homeWidget = Scaffold(
                  backgroundColor: Colors.teal,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Lottie.asset('assets/no-internet-connection.json',
                            height: MediaQuery.of(context).size.height * 0.3),
                        Text(
                          'Please switch on your Internet Connection for a better experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return homeWidget;
            }),
      ),
    );
  }
}

void getUsersLocation(BuildContext context) async {
  var location = Location();
  bool locationEnabled = await location.serviceEnabled();

  if (!locationEnabled) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'ENABLE YOUR LOCATION FOR A BETTER EXPERIENCE',
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
  WeatherData weatherData = WeatherData();
  await weatherData.getUserAddressAndLocationData();
  await weatherData.getWeatherForecast();

  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => WeatherHomePage()));
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //To get the users location, country and locality as soon they come to the app before going to the weather page.
    getUsersLocation(context);

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 30.0,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Loading',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              TypewriterAnimatedTextKit(
                speed: Duration(seconds: 2),
                text: ["..."],
                textStyle: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
