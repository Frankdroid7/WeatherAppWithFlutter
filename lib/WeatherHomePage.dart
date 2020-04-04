import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/FullDetailsWeatherPage.dart';
import 'package:weather_app/HomeHeader.dart';
import 'package:weather_app/Weather/TodayWeatherListView.dart'
    as TodayWeatherListView;
import 'package:weather_app/Weather/TomorrowWeatherListView.dart'
    as TomorrowWeatherListView;
import 'package:weather_app/Weather/WeatherDetails.dart';
import 'package:weather_app/Weather/WeeklyWeatherListView.dart'
    as WeeklyWeatherListView;

enum TabText { TODAY, TOMORROW, WEEK }

TabText selectedTab = TabText.TOMORROW;

const Color activeColor = Color(0xffEBF2FF);
const Color inActiveColor = Color(0xffffffff);

FontWeight todayFW;
FontWeight tomorrowFW;
FontWeight weekFW;

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  double height;
  double width;
  int selectedItem = 1;

  List<String> _dayType = ["Today", "Tomorrow", "Week"];
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    readTime();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: height * 0.02),
                height: height * 0.5,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.3,
                          spreadRadius: 0.3)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height * 0.05))),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: WeatherExtrasContainer()),
              ),
              Container(
                child: SafeArea(child: HomePageHeaderContent()),
                height: height * 0.4,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height * 0.05))),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          _currentTime(),
          SizedBox(
            height: height * 0.04,
          ),
          generateTab(),
          SizedBox(height: 20.0),
          if (selectedTab == TabText.TODAY)
            TodayWeatherListView.TodayWeatherListView()
          else if (selectedTab == TabText.TOMORROW)
            TomorrowWeatherListView.TomorrowWeatherListView()
          else
            WeeklyWeatherListView.WeeklyWeatherListView(),
        ],
      ),
    );
  }

  Widget _currentTime() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: '${currentTime()}\n',
          style: TextStyle(
              fontSize: 40.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text:
                  '             ${DateFormat('EEE, d MMM').format(DateTime.now())}',
              style: TextStyle(
                  height: 1.5,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget generateTab() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: height * 0.06,
        width: width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 0.3,
                  spreadRadius: 0.3)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height * 0.03),
                bottomLeft: Radius.circular(height * 0.03))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _dayType
              .asMap()
              .entries
              .map((_entry) => GestureDetector(
                    onTap: () {
                      setState(() {
                        switch (_entry.key) {
                          case 0:
                            selectedTab = TabText.TODAY;
                            selectedItem = _entry.key;
                            break;
                          case 1:
                            selectedTab = TabText.TOMORROW;
                            selectedItem = _entry.key;

                            break;
                          case 2:
                            selectedTab = TabText.WEEK;
                            selectedItem = _entry.key;

                            break;
                          default:
                            selectedTab = TabText.TOMORROW;
                            selectedItem = 1;
                        }
                      });
                    },
                    child: Container(
                      height: height * 0.3,
                      width: width * 0.3,
                      // padding: EdgeInsets.all(height * 0.02),
                      decoration: _entry.key == selectedItem
                          ? BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.03)),
                              color: Color(0XFFEBF2FF))
                          : null,
                      child: Center(
                        child: Text(
                          _entry.value,
                          style: TextStyle(
                            color: Color(0xff586171),
                            fontSize: 18.0,
                            fontWeight: selectedItem == _entry.key
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

//class TabContainer extends StatefulWidget {
//  @override
//  _TabContainerState createState() => _TabContainerState();
//}
//
//
//class _TabContainerState extends State<TabContainer> {
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      elevation: 5.0,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.only(
//          topLeft: Radius.circular(50.0),
//          bottomLeft: Radius.circular(50.0),
//        ),
//      ),
//      margin: EdgeInsets.only(left: 50.0),
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: GestureDetector(
//              onTap: () {
//                selectedTab = TabText.TODAY;
//              },
//              onLongPress: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => FullDetailsWeatherPage()));
//              },
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(
//                  Radius.circular(50.0),
//                ),
//                child: Container(
//                  color: selectedTab == TabText.TODAY
//                      ? activeColor
//                      : inActiveColor,
//                  child: Padding(
//                    padding: const EdgeInsets.all(12.0),
//                    child: Center(
//                      child: Text(
//                        'Today',
//                        style: TextStyle(
//                          color: Color(0xff586171),
//                          fontSize: 18.0,
//                          fontWeight: selectedTab == TabText.TODAY
//                              ? FontWeight.bold
//                              : FontWeight.normal,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//          Expanded(
//            child: GestureDetector(
//              onTap: () {
//                selectedTab = TabText.TOMORROW;
//              },
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(
//                  Radius.circular(50.0),
//                ),
//                child: Container(
//                  color: selectedTab == TabText.TOMORROW
//                      ? activeColor
//                      : inActiveColor,
//                  child: Padding(
//                    padding: const EdgeInsets.all(12.0),
//                    child: Center(
//                      child: Text(
//                        'Tomorrow',
//                        style: TextStyle(
//                          color: Color(0xff586171),
//                          fontSize: 18.0,
//                          fontWeight: selectedTab == TabText.TOMORROW
//                              ? FontWeight.bold
//                              : FontWeight.normal,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//          Expanded(
//            child: GestureDetector(
//              onTap: () {
//                selectedTab = TabText.WEEK;
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => FullDetailsWeatherPage(),
//                  ),
//                );
//              },
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(
//                  Radius.circular(50.0),
//                ),
//                child: Container(
//                  color:
//                      selectedTab == TabText.WEEK ? activeColor : inActiveColor,
//                  child: Padding(
//                    padding: const EdgeInsets.all(12.0),
//                    child: Center(
//                      child: Text(
//                        'Week',
//                        style: TextStyle(
//                          color: Color(0xff586171),
//                          fontSize: 18.0,
//                          fontWeight: selectedTab == TabText.WEEK
//                              ? FontWeight.bold
//                              : FontWeight.normal,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
