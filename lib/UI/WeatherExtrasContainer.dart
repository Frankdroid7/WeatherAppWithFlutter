import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/WeatherProvider.dart';
import 'package:weather_app/UI/HomeHeaderContent.dart';
import 'package:weather_app/UI/WeatherExtras.dart';
import 'package:weather_app/Weather/weather_data.dart';

class WeatherExtrasContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          WeatherExtras(
            title: 'Humidity',
            value:
                '${Provider.of<WeatherProvider>(context, listen: false).humidity}%',
            icon: FontAwesomeIcons.rainbow,
          ),
          WeatherExtras(
            title: 'Wind',
            value:
                '${Provider.of<WeatherProvider>(context, listen: false).wind}mph',
            icon: FontAwesomeIcons.wind,
          ),
          WeatherExtras(
            title: 'Feels Like',
            value:
                '${Provider.of<WeatherProvider>(context, listen: false).feelsLike}°C',
            icon: FontAwesomeIcons.coffee,
          ),
        ],
      ),
    );
  }
}
