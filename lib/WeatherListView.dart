import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 50.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 12,
          itemBuilder: (context, index) {
            return IndividualHorizontalListItem();
          }),
    );
  }
}

class IndividualHorizontalListItem extends StatelessWidget {
  const IndividualHorizontalListItem({
    Key key,
  }) : super(key: key);

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
              '9AM',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            FaIcon(
              FontAwesomeIcons.cloud,
              color: Colors.white,
            ),
            Text(
              '12°C',
              style: TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
