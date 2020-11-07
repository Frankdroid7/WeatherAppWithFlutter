import 'package:flutter/material.dart';

class IndividualWeatherDetailsItem extends StatelessWidget {
  final String _weatherTime;
  final String _weatherIcon;
  final int _weatherTemp;
  final int _weatherHumidity;

  IndividualWeatherDetailsItem(
    this._weatherTime,
    this._weatherIcon,
    this._weatherTemp,
    this._weatherHumidity,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                _weatherTime,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'TitilliumWeb-Light'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _weatherIcon,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$_weatherTemp°C',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$_weatherHumidity%',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
