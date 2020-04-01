import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart' as weather;

import '../IndividualHorizontalListItem.dart';

List listOfHourlyWeatherData;
List mListOfHourlyWeatherDataForTomorrow;
String _time;
List<String> listOfTime;
List<String> listOfWeatherIcon;
List<int> listOfWeatherTemp;
List<int> listOfWeatherHumidity;
int _temp;
bool isTomorrowWeatherDataLoading = true;

class TomorrowWeatherListView extends StatefulWidget {
  @override
  _TomorrowWeatherListViewState createState() =>
      _TomorrowWeatherListViewState();
}

class _TomorrowWeatherListViewState extends State<TomorrowWeatherListView> {
  @override
  void initState() {
    super.initState();
    getHourlyForecastForTomorrow();
  }

  void getHourlyForecastForTomorrow() async {
    //Get User's Coordinate first.
    LocationHelper _locationHelper = LocationHelper();
    await _locationHelper.getUserCoordinate();

    //Url for hourly forecast
    String urlForHourlyForecast =
        '$kBaseUrl/forecast?lat=${_locationHelper.latitude}&lon=${_locationHelper.longitude}&appid=$kAppId&units=metric';

    //Get json data from opeanweathermap.org
    NetworkHelper _networkHelper = NetworkHelper(url: urlForHourlyForecast);

    //To get the list of Hourly Weather Forecast.
    var weatherData = await _networkHelper.getData();
    listOfHourlyWeatherData = weatherData['list'];

    //To initialize mListOfHourlyWeatherData
    mListOfHourlyWeatherDataForTomorrow = List();
    listOfTime = List();
    listOfWeatherIcon = List();
    listOfWeatherTemp = List();
    listOfWeatherHumidity = List();

    var dateForTomorrow = DateTime.now().add(Duration(hours: 24));

    var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');
    for (int i = 0; i < listOfHourlyWeatherData.length; i++) {
      var justDateFromApi =
          regExpForDate.stringMatch(listOfHourlyWeatherData[i]['dt_txt']);
      var justTomorrowDateFromLocal =
          regExpForDate.stringMatch(dateForTomorrow.toString());

      if (justDateFromApi == justTomorrowDateFromLocal) {
        mListOfHourlyWeatherDataForTomorrow.add(listOfHourlyWeatherData[i]);
      }
    }
    isTomorrowWeatherDataLoading = false;
  }

  String mTime({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = mListOfHourlyWeatherDataForTomorrow[currentIndex]['dt_txt'];
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
    var temperature =
        mListOfHourlyWeatherDataForTomorrow[currentIndex]['main']['temp'];
    _temp = temperature.toInt();
    listOfWeatherTemp.add(_temp);
    return _temp;
  }

  String mWeatherIcon({int currentIndex}) {
    var weatherCondition =
        mListOfHourlyWeatherDataForTomorrow[currentIndex]['weather'][0]['id'];
    listOfWeatherIcon.add(weather.getWeatherIcon(weatherCondition));
    return weather.getWeatherIcon(weatherCondition);
  }

  void mWeatherHumidity({int currentIndex}) {
    var weatherHumidity =
        mListOfHourlyWeatherDataForTomorrow[0]['main']['humidity'];

    listOfWeatherHumidity.add(weatherHumidity);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: isTomorrowWeatherDataLoading == true
          ? SpinKitHourGlass(
              color: Colors.orange,
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: mListOfHourlyWeatherDataForTomorrow.length,
              itemBuilder: (context, index) {
                mWeatherHumidity(currentIndex: index);
                return IndividualHorizontalListItem(
                  temp: mTemp(currentIndex: index),
                  time: mTime(currentIndex: index),
                  weatherIcon: mWeatherIcon(currentIndex: index),
                );
              }),
    );
  }
}

//Widget widgetToShow;
//if (isTomorrowWeatherDataLoading == true) {
//widgetToShow = Text('Come back tomorrow to check weather');
//} else {
//IndividualHorizontalListItem(
//temp: mTemp(currentIndex: index),
//time: mTime(currentIndex: index),
//weatherIcon: mWeatherIcon(currentIndex: index),
//);
//}
//return widgetToShow;
