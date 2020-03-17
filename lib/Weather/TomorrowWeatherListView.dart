import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Weather/weather.dart' as weather;

List listOfHourlyWeatherData;
List mListOfHourlyWeatherDataForTomorrow;
String _time;
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

    var dateForTomorrow = DateTime.now().add(Duration(hours: 24));

    var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');
    for (int i = 0; i < listOfHourlyWeatherData.length; i++) {
      print('hiiiiiiiiiiiiiiiiiiiii: $i');
      var justDateFromApi =
          regExpForDate.stringMatch(listOfHourlyWeatherData[i]['dt_txt']);
      var justTomorrowDateFromLocal =
          regExpForDate.stringMatch(dateForTomorrow.toString());
      print('justDateFromApi: $justDateFromApi');
      print('justDateFromLocal: $justTomorrowDateFromLocal');

      if (justDateFromApi == justTomorrowDateFromLocal) {
        mListOfHourlyWeatherDataForTomorrow.add(listOfHourlyWeatherData[i]);
        print('mListOfHourlyWeatherData: $mListOfHourlyWeatherDataForTomorrow');
      }
    }
    isTomorrowWeatherDataLoading = false;
  }

  String mTime({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = mListOfHourlyWeatherDataForTomorrow[currentIndex]['dt_txt'];
    var timeMatch = regExp.stringMatch(_time);
    if (timeMatch == '00:00') {
      return '12AM';
    } else if (timeMatch == '03:00') {
      return '3AM';
    } else if (timeMatch == '06:00') {
      return '6AM';
    } else if (timeMatch == '09:00') {
      return '9AM';
    } else if (timeMatch == '12:00') {
      return '12PM';
    } else if (timeMatch == '15:00') {
      return '3PM';
    } else if (timeMatch == '18:00') {
      return '6PM';
    } else if (timeMatch == '21:00') {
      return '9PM';
    }
    return '';
  }

  int mTemp({int currentIndex}) {
    var temperature =
        mListOfHourlyWeatherDataForTomorrow[currentIndex]['main']['temp'];
    _temp = temperature.toInt();
    return _temp;
  }

  String mWeatherIcon({int currentIndex}) {
    var weatherCondition =
        mListOfHourlyWeatherDataForTomorrow[currentIndex]['weather'][0]['id'];
    return weather.getWeatherIcon(weatherCondition);
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
              padding: EdgeInsets.only(bottom: 50.0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: mListOfHourlyWeatherDataForTomorrow.length,
              itemBuilder: (context, index) {
                return IndividualHorizontalListItem(
                  temp: mTemp(currentIndex: index),
                  time: mTime(currentIndex: index),
                  weatherIcon: mWeatherIcon(currentIndex: index),
                );
              }),
    );
  }
}

class IndividualHorizontalListItem extends StatelessWidget {
  final dynamic temp;
  final String time;
  final String weatherIcon;

  IndividualHorizontalListItem(
      {@required this.temp, @required this.time, @required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '$time',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            Text(
              weatherIcon,
              style: TextStyle(fontSize: 50.0),
            ),
            Text(
              '$temp°C',
              style: TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
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
