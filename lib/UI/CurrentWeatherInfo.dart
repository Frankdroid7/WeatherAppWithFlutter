import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/UserProvider.dart';
import 'package:weather_app/Provider/WeatherProvider.dart';

//To show the User's current weather data
class CurrentWeatherInfo extends StatefulWidget {
  @override
  _CurrentWeatherInfoState createState() => _CurrentWeatherInfoState();
}

class _CurrentWeatherInfoState extends State<CurrentWeatherInfo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -0.2))
        .animate(_controller);

    _controller.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome ${Provider.of<UserProvider>(context, listen: false).firstName}',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            Row(
              children: <Widget>[
                SlideTransition(
                  position: _animation,
                  child: Text(
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherIcon,
                    style: TextStyle(fontSize: 60.0),
                  ),
                ),
                Text(
                  'Temp: ${Provider.of<WeatherProvider>(context, listen: false).currentTemp}°C',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            // Text(
            //   'Description: ${Provider.of<WeatherProvider>(context, listen: false).weatherDesc}',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 22.0,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
