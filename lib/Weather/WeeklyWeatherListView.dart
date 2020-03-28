import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/IndividualHorizontalListItem.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart' as Weather;

var mListOfWeeklyForecast = List();
List<int> mListOfWeeklyWeatherTemp = List();
List<String> mDayOfTheWeekList = List();
List<String> mListOfWeeklyWeatherIcon = List();
List<int> mListOfWeeklyWeatherHumidity = List();

bool isWeeklyWeatherDataLoading = true;

void getWeeklyWeatherForecast() async {
  LocationHelper _locationHelper = LocationHelper();
  await _locationHelper.getUserCoordinate();

  //Url for weekly forecast
  String urlForWeeklyForecast =
      '$kBaseUrl/forecast?lat=${_locationHelper.latitude}&lon=${_locationHelper.longitude}&appid=$kAppId&units=metric';

  NetworkHelper _networkHelper = NetworkHelper(url: urlForWeeklyForecast);

  var weatherData = await _networkHelper.getData();

  var listOfWeeklyForecast = weatherData['list'];

  var regExpForTime = RegExp('12:00');

  for (int i = 0; i < listOfWeeklyForecast.length; i++) {
    var dateTime = listOfWeeklyForecast[i]['dt_txt'];
    if (regExpForTime.hasMatch(dateTime)) {
      mListOfWeeklyForecast.add(listOfWeeklyForecast[i]);
    }
  }
  print('list of weekly forecast: $mListOfWeeklyForecast');
  isWeeklyWeatherDataLoading = false;
}

String getDayOfWeek({int currentIndex}) {
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

  return mDayOfTheWeekList[currentIndex];
}

int getTemp({int currentIndex}) {
  var eachWeatherTemp = mListOfWeeklyForecast[currentIndex]['main']['temp'];
  var _temp = eachWeatherTemp.toInt();
  mListOfWeeklyWeatherTemp.add(_temp);

  return _temp;
}

String getWeatherIcon({int currentIndex}) {
  var eachWeatherId = mListOfWeeklyForecast[currentIndex]['weather'][0]['id'];
  mListOfWeeklyWeatherIcon.add(Weather.getWeatherIcon(eachWeatherId));

  return Weather.getWeatherIcon(eachWeatherId);
}

void getWeatherHumidity({int currentIndex}) {
  var weatherHumidity = mListOfWeeklyForecast[currentIndex]['main']['humidity'];

  mListOfWeeklyWeatherHumidity.add(weatherHumidity);
}

class WeeklyWeatherListView extends StatefulWidget {
  @override
  _WeeklyWeatherListViewState createState() => _WeeklyWeatherListViewState();
}

class _WeeklyWeatherListViewState extends State<WeeklyWeatherListView> {
  @override
  void initState() {
    super.initState();
    getWeeklyWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isWeeklyWeatherDataLoading == true
          ? SpinKitHourGlass(
              color: Colors.orange,
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: 50.0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                getWeatherHumidity(currentIndex: index);
                return IndividualHorizontalListItem(
                  temp: getTemp(currentIndex: index),
                  time: getDayOfWeek(currentIndex: index),
                  weatherIcon: getWeatherIcon(currentIndex: index),
                );
              }),
    );
  }
}
