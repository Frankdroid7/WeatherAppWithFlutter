import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/WeatherHomePage.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff21335C),
      ),
      home: HomeWidget(),
    );
  }

}

void getUsersLocation(BuildContext context) async {
  print('getting users LOCATION');

  LocationHelper _locationHelper = LocationHelper();
  await _locationHelper.getUserCountryAndLocality();

  Navigator.push(
      context,
      MaterialPageRoute
        (builder: (context) => WeatherHomePage()));
}


class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //To get the users location, country and locality as soon they come to the app before going to the weather page.
    getUsersLocation(context);
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text('Loading...', style: TextStyle(
          fontSize: 30.0, color: Colors.white
        ),)
      ),
    );
  }

}
