import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

import 'weather_data.dart';

class HomePageHeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LocationLabel(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LocationRichText(),
                  GestureDetector(
                      onTap: () {
                        Share.share(
                          'Check out a weather app: http://play.google.com/store/apps/details?id=frankdroid7.weather_app',
                          subject: 'A subject',
                        );
                      },
                      child: Icon(Icons.share, color: Colors.white)),
                ],
              ),
              CurrentWeatherInfo(),
            ],
          ),
        ),
      ],
    );
  }
}

//Text that shows the User's Country and Locality.
class LocationRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${WeatherData.userLocality}\n',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '${WeatherData.userCountry}',
            style: TextStyle(
              height: 1.5,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SlideTransition(
              position: _animation,
              child: Text(
                '${WeatherData.weatherIcon}',
                style: TextStyle(fontSize: 60.0),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              '${WeatherData.temp}°C',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
              ),
            )
          ],
        ),
        Text(
          '${WeatherData.tempDesc}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}

//To show the location tag at the top of the HomePage.
class LocationLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Your current location',
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class WeatherExtrasContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          WeatherData.isCurrentWeatherLoading == true
              ? SpinKitHourGlass(
                  color: Colors.orange,
                )
              : WeatherExtras(
                  title: 'Humidity',
                  value: '${WeatherData.humidity}%',
                  icon: FontAwesomeIcons.rainbow,
                ),
          WeatherData.isCurrentWeatherLoading == true
              ? SpinKitHourGlass(
                  color: Colors.orange,
                )
              : WeatherExtras(
                  title: 'Wind',
                  value: '${WeatherData.wind}mph',
                  icon: FontAwesomeIcons.wind,
                ),
          WeatherData.isCurrentWeatherLoading == true
              ? SpinKitHourGlass(
                  color: Colors.orange,
                )
              : WeatherExtras(
                  title: 'Feels Like',
                  value: '${WeatherData.feelsLike}°C',
                  icon: FontAwesomeIcons.coffee,
                ),
        ],
      ),
    );
  }
}

class WeatherExtras extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  WeatherExtras(
      {@required this.title, @required this.value, @required this.icon});

  @override
  _WeatherExtrasState createState() => _WeatherExtrasState();
}

class _WeatherExtrasState extends State<WeatherExtras> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FaIcon(
            widget.icon,
            size: 18.0,
          ),
        ),
        SizedBox(width: 10.0),
        RichText(
          text: TextSpan(
            text: '${widget.title}\n',
            style: TextStyle(color: Color(0xff2B3E6C), fontSize: 18.0),
            children: <TextSpan>[
              TextSpan(
                text: widget.value,
                style: TextStyle(
                    color: Color(0xff2B3E6C),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
