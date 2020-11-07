import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/UI/WeatherHomePage.dart';
import 'package:weather_app/Weather/weather_data.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    getUsersLocation(context);
  }

  @override
  Widget build(BuildContext context) {
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

//To get the users location, country and locality as soon they come to the app before going to the weather page.
void getUsersLocation(BuildContext context) async {
  Location location = Location();
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
