import 'package:flutter/material.dart';
import 'package:weather_app/UI/CustomWidgets/IndividualHorizontalListItem.dart';
import 'package:weather_app/UI/WeatherHomePage.dart';
import 'package:weather_app/Weather/weather_data.dart';

class WeatherListView extends StatelessWidget {
  final List weatherList;
  final TabText weatherEnum;

  WeatherListView({@required this.weatherList, @required this.weatherEnum});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: weatherList
              .isNotEmpty //If weather data is not empty, show the ListView.
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                WeatherData.getWeatherHumidity(
                    weatherList: weatherList, currentIndex: index);
                return IndividualHorizontalListItem(
                  temp: WeatherData.getTemp(
                      weatherList: weatherList, currentIndex: index),
                  time: weatherEnum == TabText.WEEK
                      ? WeatherData.getDayOfWeek(currentIndex: index)
                      : weatherEnum == TabText.TODAY
                          ? WeatherData.getTimeForToday(currentIndex: index)
                          : WeatherData.getTimeForTomorrow(currentIndex: index),
                  weatherIcon: WeatherData.getWeatherIcon(
                      weatherList: weatherList, currentIndex: index),
                );
              })
          : Center(
              child: Text(
                'No data today, come tomorrow!',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
    );
  }
}
