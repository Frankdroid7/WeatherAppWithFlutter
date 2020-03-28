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

TabText selectedTab = TabText.TODAY;

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
                  WeatherExtrasContainer()
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Center(
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
                  ),
                  SizedBox(height: 10.0),
                  if (selectedTab == TabText.TODAY &&
                      TodayWeatherListView.isTodayWeatherDataLoading == false &&
                      TodayWeatherListView.mListOfHourlyWeatherData.length > 0)
                    Center(
                        child:
                            Text('Double Click "Today" to view full screen.')),
                  if (selectedTab == TabText.TOMORROW &&
                      TomorrowWeatherListView.isTomorrowWeatherDataLoading ==
                          false)
                    Center(
                        child: Text(
                            'Double Click "Tomorrow" to view full screen.')),
                  if (selectedTab == TabText.WEEK &&
                      WeeklyWeatherListView.isWeeklyWeatherDataLoading == false)
                    Center(
                        child:
                            Text('Double Click "Week" to view full screen.')),
                  SizedBox(height: 10.0),
                  Card(
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
                              setState(() {
                                selectedTab = TabText.TODAY;
                              });
                            },
                            onDoubleTap: () {
                              if (TodayWeatherListView
                                          .isTodayWeatherDataLoading ==
                                      false &&
                                  TodayWeatherListView
                                          .mListOfHourlyWeatherData.length >
                                      0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullDetailsWeatherPage(
                                      WeatherDetails(
                                          weatherMoment: 'Today',
                                          weatherTime:
                                              TodayWeatherListView.listOfTime,
                                          weatherIcon: TodayWeatherListView
                                              .listOfWeatherIcon,
                                          weatherTemp: TodayWeatherListView
                                              .listOfWeatherTemp,
                                          weatherHumidity: TodayWeatherListView
                                              .listOfWeatherHumidity,
                                          weatherDetailsLength:
                                              TodayWeatherListView
                                                  .mListOfHourlyWeatherData
                                                  .length),
                                    ),
                                  ),
                                );
                              }
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
                              setState(() {
                                selectedTab = TabText.TOMORROW;
                              });
                            },
                            onDoubleTap: () {
                              if (TomorrowWeatherListView
                                      .isTomorrowWeatherDataLoading ==
                                  false) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FullDetailsWeatherPage(WeatherDetails(
                                                weatherMoment: 'Tomorrow',
                                                weatherTime:
                                                    TomorrowWeatherListView
                                                        .listOfTime,
                                                weatherIcon:
                                                    TomorrowWeatherListView
                                                        .listOfWeatherIcon,
                                                weatherTemp:
                                                    TomorrowWeatherListView
                                                        .listOfWeatherTemp,
                                                weatherHumidity:
                                                    TomorrowWeatherListView
                                                        .listOfWeatherHumidity,
                                                weatherDetailsLength:
                                                    TomorrowWeatherListView
                                                        .mListOfHourlyWeatherDataForTomorrow
                                                        .length))));
                              }
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
                                        fontWeight:
                                            selectedTab == TabText.TOMORROW
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
                              setState(() {
                                selectedTab = TabText.WEEK;
                              });
                            },
                            onDoubleTap: () {
                              if (WeeklyWeatherListView
                                      .isWeeklyWeatherDataLoading ==
                                  false) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FullDetailsWeatherPage(WeatherDetails(
                                      weatherMoment: 'Week',
                                      weatherTime: WeeklyWeatherListView
                                          .mDayOfTheWeekList,
                                      weatherTemp: WeeklyWeatherListView
                                          .mListOfWeeklyWeatherTemp,
                                      weatherDetailsLength: 5,
                                      weatherHumidity: WeeklyWeatherListView
                                          .mListOfWeeklyWeatherHumidity,
                                      weatherIcon: WeeklyWeatherListView
                                          .mListOfWeeklyWeatherIcon));
                                }));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              child: Container(
                                color: selectedTab == TabText.WEEK
                                    ? activeColor
                                    : inActiveColor,
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
                  ),
                  SizedBox(height: 20.0),
                  if (selectedTab == TabText.TODAY)
                    TodayWeatherListView.TodayWeatherListView()
                  else if (selectedTab == TabText.TOMORROW)
                    TomorrowWeatherListView.TomorrowWeatherListView()
                  else
                    WeeklyWeatherListView.WeeklyWeatherListView(),
                ],
              ),
            ),
          ),
        ],
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
