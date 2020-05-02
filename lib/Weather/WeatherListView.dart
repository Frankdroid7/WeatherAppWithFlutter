import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/WeatherHomePage.dart';
import 'package:weather_app/Weather/weather.dart' as Weather;

import '../IndividualHorizontalListItem.dart';
import 'package:weather_app/HomeHeaderContent.dart';

LocationHelper _locationHelper = LocationHelper();
List listOfWeatherData;
List mListOfWeatherData;
String _time;
List<String> listOfTime;
List<String> listOfWeatherIcon;
List<int> listOfWeatherTemp;
List<int> listOfWeatherHumidity;
bool isWeatherDataLoading = true;

class WeatherListView extends StatefulWidget {
  final _weatherType;

  WeatherListView(this._weatherType);

  @override
  _WeatherListViewState createState() => _WeatherListViewState();
}

class _WeatherListViewState extends State<WeatherListView> {
  @override
  void initState() {
    super.initState();
    //To get the weather forecast immediately this WeatherListView widget gets created.
    getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: isWeatherDataLoading == true
            ? SpinKitHourGlass(
                color: Colors.orange,
              )
            : mListOfWeatherData.isNotEmpty //If weather data is not empty, show the ListView.
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget._weatherType == TabText.WEEK
                        ? 5 //The highest number of days we can get from the api for weekly weather is 5.
                        : mListOfWeatherData.length,
                    itemBuilder: (context, index) {
                      getWeatherHumidity(currentIndex: index);
                      return IndividualHorizontalListItem(
                        temp: getTemp(currentIndex: index),
                        time: widget._weatherType == TabText.WEEK
                            ? getDayOfWeek(currentIndex: index)
                            : getTime(currentIndex: index),
                        weatherIcon: getWeatherIcon(currentIndex: index),
                      );
                    })
                : Center(
                    child: Text(
                      'No data today, come tomorrow!',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ));
  }

  void getWeatherForecast() async {

//To get user's coordinate
    await _locationHelper.getUserCoordinate();

    //Url to get weather forecast
    String weatherEndpoint =
        '$kBaseUrl/forecast?lat=${_locationHelper.latitude}&lon=${_locationHelper.longitude}&appid=$kAppId&units=metric';

    //Get json data from opeanweathermap.org
    NetworkHelper _networkHelper = NetworkHelper(url: weatherEndpoint);

    //To get the list of Weather Forecast
    var weatherData = await _networkHelper.getData();
    listOfWeatherData = weatherData['list'];

    //To initialize all variables.
    mListOfWeatherData = List();
    listOfTime = List();
    listOfWeatherIcon = List();
    listOfWeatherTemp = List();
    listOfWeatherHumidity = List();

    //To wait for 'getting weather list' to be completed.
    await getWeatherList();

    //To notify that all weather data have been gotten so that we can remove the loading SpinKitHourGlass and show the data.
    isWeatherDataLoading = false;
  }

  Future getWeatherList() async {

    //To know what date, the date from the api should match.
    String dateToMatch;

    var dateForToday = DateTime.now().add(Duration(hours: 0)).toString();
    var dateForTomorrow = DateTime.now().add(Duration(hours: 24)).toString();

    //Variable to hold the time at 3:00 pm. To show each day of the week 3PM weather.
    var timeForWeeklyWeather = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, 15)
        .toString();

    if (widget._weatherType == TabText.TODAY) {
      dateToMatch = dateForToday;
    } else if (widget._weatherType == TabText.TOMORROW) {
      dateToMatch = dateForTomorrow;
    } else {
      dateToMatch = timeForWeeklyWeather;
    }

    //Regex to help match weather date. E.g 2020-05-02
    var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');


    dateToMatch = regExpForDate.stringMatch(dateToMatch);

    //To loop through all weather data and get date from each of them. If it matches the current dateToMatch, add it to a new list. (It is this new list data we would show).
    for (int i = 0; i < listOfWeatherData.length; i++) {
      var matchesDate =
          listOfWeatherData[i]['dt_txt'].toString().contains(dateToMatch);

      if (matchesDate) {
        mListOfWeatherData.add(listOfWeatherData[i]);
      }
    }
  }

  //To show the time in xAM OR xPM like 3AM, 12PM.
  String getTime({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = mListOfWeatherData[currentIndex]['dt_txt'];
    var timeMatch = regExp.stringMatch(_time);
    if (timeMatch == '00:00') {
      listOfTime.add('12AM');
      return '12AM';
    } else if (timeMatch == '03:00') {
      listOfTime.add('3AM');
      return '3AM';
    } else if (timeMatch == '06:00') {
      listOfTime.add('6AM');
      return '6AM';
    } else if (timeMatch == '09:00') {
      listOfTime.add('9AM');
      return '9AM';
    } else if (timeMatch == '12:00') {
      listOfTime.add('12PM');
      return '12PM';
    } else if (timeMatch == '15:00') {
      listOfTime.add('3PM');
      return '3PM';
    } else if (timeMatch == '18:00') {
      listOfTime.add('6PM');
      return '6PM';
    } else if (timeMatch == '21:00') {
      listOfTime.add('9PM');
      return '9PM';
    }
    return '';
  }

  //To get weather temperature.
  int getTemp({int currentIndex}) {
    var temperature = mListOfWeatherData[currentIndex]['main']['temp'];
    var _temp = temperature.toInt();
    listOfWeatherTemp.add(_temp);
    return _temp;
  }

  //To get weather icon.
  String getWeatherIcon({int currentIndex}) {
    var weatherCondition = mListOfWeatherData[currentIndex]['weather'][0]['id'];
    listOfWeatherIcon.add(Weather.getWeatherIcon(weatherCondition));
    return Weather.getWeatherIcon(weatherCondition);
  }

  //If the 'dateToMatch' is for weekly weather, this is the function to get each day of the week.
  String getDayOfWeek({int currentIndex}) {
    List<String> mDayOfTheWeekList = List();

    var currentDateTime = DateTime.now();
    var dayOfTheWeekFormat = DateFormat('EEEE');

    for (int i = 1; i <= 5; i++) {
      mDayOfTheWeekList.add(
        dayOfTheWeekFormat.format(
          currentDateTime.add(
            Duration(days: i),
          ),
        ),
      );
    }

    return mDayOfTheWeekList[currentIndex].substring(0, 3);
  }

  //To get weather humidity.
  void getWeatherHumidity({int currentIndex}) {
    var weatherHumidity = mListOfWeatherData[0]['main']['humidity'];

    listOfWeatherHumidity.add(weatherHumidity);
  }
}
