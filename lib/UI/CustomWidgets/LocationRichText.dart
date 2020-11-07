import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/WeatherProvider.dart';
import 'package:weather_app/Weather/weather_data.dart';

//Text that shows the User's Country and Locality.
class LocationRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: WeatherProvider(),
      child: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return RichText(
            text: TextSpan(
              text: '${weatherProvider.userLocality}\n',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${weatherProvider.userCountry}',
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
