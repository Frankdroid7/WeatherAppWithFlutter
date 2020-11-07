import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:weather_app/UI/CurrentWeatherInfo.dart';
import 'package:weather_app/UI/CustomWidgets/LocationLabel.dart';
import 'package:weather_app/UI/CustomWidgets/LocationRichText.dart';

import 'SignInWidget.dart';
import '../main.dart';

class HomePageHeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LocationLabel(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _signOut(context);
                },
                color: Colors.red,
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LocationRichText(),
                    GestureDetector(
                        onTap: () {
                          Share.share(
                            'Check out a weather app: http://play.google.com/store/apps/details?id=frankdroid7.weather_app',
                            subject: 'A subject',
                          );
                        },
                        child: Icon(Icons.share, color: Colors.white)),
                  ],
                ),
                CurrentWeatherInfo(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

_signOut(BuildContext context) {
  signOutGoogle().whenComplete(() {
    localStorage.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInWidget()));
  });
}
