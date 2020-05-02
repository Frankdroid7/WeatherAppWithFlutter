import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/FullDetailsWeatherPage.dart';
import 'package:weather_app/HomeHeaderContent.dart';
import 'package:weather_app/Weather/WeatherDetails.dart';
import 'Weather/WeatherListView.dart';

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
  double height;
  double width;
  int selectedItem = 0;

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
  void initState() {
    super.initState();
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
                    alignment: Alignment.bottomRight,
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
          if (selectedTab == TabText.TODAY &&
              isWeatherDataLoading == false &&
              mListOfWeatherData.length > 0)
            Center(child: Text('Double Click "Today" to view full screen.')),
          if (selectedTab == TabText.TOMORROW && isWeatherDataLoading == false)
            Center(child: Text('Double Click "Tomorrow" to view full screen.')),
          if (selectedTab == TabText.WEEK && isWeatherDataLoading == false)
            Center(child: Text('Double Click "Week" to view full screen.')),
          SizedBox(
            height: height * 0.04,
          ),
          generateTab(),
          SizedBox(height: 20.0),
          if (selectedTab == TabText.TODAY)
            WeatherListView(TabText.TODAY)
          else if (selectedTab == TabText.TOMORROW)
            WeatherListView(TabText.TOMORROW)
          else
            WeatherListView(TabText.WEEK),
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
                  blurRadius: 10.0,
                  spreadRadius: 5.3),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10.0,
                  spreadRadius: 5.3)
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
                            selectedTab = TabText.TODAY;
                            selectedItem = 0;
                        }
                      });
                    },

            //To show the weather details in full screen when we double tab a text in the tab. 
                    onDoubleTap: () {
                      switch (_entry.key) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullDetailsWeatherPage(
                                      WeatherDetails(
                                          weatherMoment: "TODAY",
                                          weatherTime: listOfTime,
                                          weatherIcon: listOfWeatherIcon,
                                          weatherHumidity: listOfWeatherHumidity,
                                          weatherTemp: listOfWeatherTemp,
                                          weatherDetailsLength:
                                          mListOfWeatherData.length))));
                          break;

                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullDetailsWeatherPage(
                                      WeatherDetails(
                                          weatherMoment: "TOMORROW",
                                          weatherTime: listOfTime,
                                          weatherIcon: listOfWeatherIcon,
                                          weatherHumidity: listOfWeatherHumidity,
                                          weatherTemp: listOfWeatherTemp,
                                          weatherDetailsLength:
                                          mListOfWeatherData.length))));
                          break;

                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullDetailsWeatherPage(
                                      WeatherDetails(
                                          weatherMoment: "WEEK",
                                          weatherTime: listOfTime,
                                          weatherIcon: listOfWeatherIcon,
                                          weatherHumidity: listOfWeatherHumidity,
                                          weatherTemp: listOfWeatherTemp,
                                          weatherDetailsLength:
                                          mListOfWeatherData.length))));

                          break;

                        default:
                          selectedTab = TabText.TODAY;
                          selectedItem = 0;
                      }
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
