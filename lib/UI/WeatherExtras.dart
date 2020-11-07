import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
