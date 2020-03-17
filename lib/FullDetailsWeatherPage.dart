import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/Location/locationHelper.dart';

class FullDetailsWeatherPage extends StatefulWidget {
  @override
  _FullDetailsWeatherPageState createState() => _FullDetailsWeatherPageState();
}

class _FullDetailsWeatherPageState extends State<FullDetailsWeatherPage> {
  final bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () => print('woken up'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.commentDots,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 20.0,
              ),
              child: Image.asset(
                'images/random_img2.png',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Week',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
            SpinKitRing(
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
