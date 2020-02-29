import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/FullDetailsWeatherPage.dart';
import 'package:weather_app/HomeHeader.dart';
import 'package:weather_app/WeatherListView.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String currentTime() {
    String now;
    setState(() {
      now = DateFormat("HH:mm aa").format(DateTime.now());
    });
    return now;
  }

  void readTime() {
    Timer.periodic(Duration(seconds: 0), (Timer t) => {currentTime()});
  }

  @override
  Widget build(BuildContext context) {
    readTime();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //First 'root' CardView
          Expanded(
            flex: 1,
            //First 'White' Card
            child: Card(
              margin: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 10.0,
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: SafeArea(child: HomePageHeaderContent()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          WeatherExtras(
                            title: 'Humidity',
                            value: '75%',
                            icon: FontAwesomeIcons.rainbow,
                          ),
                          WeatherExtras(
                            title: 'Wind',
                            value: '10 mph',
                            icon: FontAwesomeIcons.wind,
                          ),
                          WeatherExtras(
                            title: 'Feels Like',
                            value: '12°C',
                            icon: FontAwesomeIcons.coffee,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //Second 'root' CardView
          Expanded(
            flex: 1,
            child: Card(
              margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  RichText(
                    text: TextSpan(
                      text: '${currentTime()}\n',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '              ${DateFormat('EEE, d MMM').format(DateTime.now())}',
                          style: TextStyle(
                              height: 1.5,
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TabContainer(),
                  SizedBox(height: 20.0),
                  WeatherListView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TabText { TODAY, TOMORROW, WEEK }

TabText selectedTab = TabText.TODAY;

const Color activeColor = Color(0xffEBF2FF);
const Color inActiveColor = Color(0xffffffff);

FontWeight todayFW;
FontWeight tomorrowFW;
FontWeight weekFW;

class TabContainer extends StatefulWidget {
  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
        ),
      ),
      margin: EdgeInsets.only(left: 50.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = TabText.TODAY;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                child: Container(
                  color: selectedTab == TabText.TODAY
                      ? activeColor
                      : inActiveColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: Color(0xff586171),
                          fontSize: 18.0,
                          fontWeight: selectedTab == TabText.TODAY
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = TabText.TOMORROW;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                child: Container(
                  color: selectedTab == TabText.TOMORROW
                      ? activeColor
                      : inActiveColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Tomorrow',
                        style: TextStyle(
                          color: Color(0xff586171),
                          fontSize: 18.0,
                          fontWeight: selectedTab == TabText.TOMORROW
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = TabText.WEEK;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullDetailsWeatherPage(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                child: Container(
                  color:
                      selectedTab == TabText.WEEK ? activeColor : inActiveColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Week',
                        style: TextStyle(
                          color: Color(0xff586171),
                          fontSize: 18.0,
                          fontWeight: selectedTab == TabText.WEEK
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherExtras extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  WeatherExtras(
      {@required this.title, @required this.value, @required this.icon});

  @override
  _WeatherExtrasState createState() => _WeatherExtrasState();
}

class _WeatherExtrasState extends State<WeatherExtras> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FaIcon(
            widget.icon,
            size: 18.0,
          ),
        ),
        SizedBox(width: 10.0),
        RichText(
          text: TextSpan(
            text: '${widget.title}\n',
            style: TextStyle(color: Color(0xff2B3E6C), fontSize: 18.0),
            children: <TextSpan>[
              TextSpan(
                text: widget.value,
                style: TextStyle(
                    color: Color(0xff2B3E6C),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}