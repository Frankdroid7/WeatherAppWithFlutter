import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart' as weather;

import '../Constants/constants.dart';
import '../IndividualHorizontalListItem.dart';

List listOfHourlyWeatherData;
List mListOfHourlyWeatherData;
String _time;
List<String> listOfTime;
List<String> listOfWeatherIcon;
List<int> listOfWeatherTemp;
List<int> listOfWeatherHumidity;
bool isTodayWeatherDataLoading = true;

class TodayWeatherListView extends StatefulWidget {
  @override
  _TodayWeatherListViewState createState() => _TodayWeatherListViewState();
}

class _TodayWeatherListViewState extends State<TodayWeatherListView> {
  @override
  void initState() {
    super.initState();
    getHourlyForecastForToday();
  }

  void getHourlyForecastForToday() async {
    //Get User's Coordinate first.
    LocationHelper _locationHelper = LocationHelper();
    await _locationHelper.getUserCoordinate();

    print('FINISH WAITING');

    //Url for hourly forecast
    String urlForHourlyForecast =
        '$kBaseUrl/forecast?lat=${_locationHelper.latitude}&lon=${_locationHelper.longitude}&appid=$kAppId&units=metric';

    //Get json data from opeanweathermap.org
    NetworkHelper _networkHelper = NetworkHelper(url: urlForHourlyForecast);

    //To get the list of Hourly Weather Forecast.
    var weatherData = await _networkHelper.getData();
    listOfHourlyWeatherData = weatherData['list'];

    mListOfHourlyWeatherData = List();
    listOfTime = List();
    listOfWeatherIcon = List();
    listOfWeatherTemp = List();
    listOfWeatherHumidity = List();

    var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');
    for (int i = 0; i < listOfHourlyWeatherData.length; i++) {
      var justDateFromApi =
          regExpForDate.stringMatch(listOfHourlyWeatherData[i]['dt_txt']);
      var justDateFromLocal =
          regExpForDate.stringMatch(DateTime.now().toString());

      if (justDateFromApi == justDateFromLocal) {
        mListOfHourlyWeatherData.add(listOfHourlyWeatherData[i]);
      }
    }
    print('mListOfHourlyWeatherData: $mListOfHourlyWeatherData');
    isTodayWeatherDataLoading = false;
  }

  String mTime({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = mListOfHourlyWeatherData[currentIndex]['dt_txt'];
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

  int mTemp({int currentIndex}) {
    var temperature = mListOfHourlyWeatherData[currentIndex]['main']['temp'];
    var _temp = temperature.toInt();
    listOfWeatherTemp.add(_temp);
    return _temp;
  }

  String mWeatherIcon({int currentIndex}) {
    var weatherCondition =
        mListOfHourlyWeatherData[currentIndex]['weather'][0]['id'];
    listOfWeatherIcon.add(weather.getWeatherIcon(weatherCondition));
    return weather.getWeatherIcon(weatherCondition);
  }

  void mWeatherHumidity({int currentIndex}) {
    var weatherHumidity =
        mListOfHourlyWeatherData[currentIndex]['main']['humidity'];

    listOfWeatherHumidity.add(weatherHumidity);
  }

  @override
  Widget build(BuildContext context) {
    if (isTodayWeatherDataLoading == true) {
      return SpinKitHourGlass(
        color: Colors.orange,
      );
    } else {
      if (mListOfHourlyWeatherData.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mListOfHourlyWeatherData.length,
              itemBuilder: (context, index) {
                mWeatherHumidity(currentIndex: index);
                return IndividualHorizontalListItem(
                  temp: mTemp(currentIndex: index),
                  time: mTime(currentIndex: index),
                  weatherIcon: mWeatherIcon(currentIndex: index),
                );
              }),
        );
      } else {
        return Center(
          child: Text(
            'No data today, come tomorrow!',
            style: TextStyle(fontSize: 25.0),
          ),
        );
      }
    }
  }
}
