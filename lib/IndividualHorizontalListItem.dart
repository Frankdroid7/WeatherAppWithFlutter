import 'package:flutter/material.dart';

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
