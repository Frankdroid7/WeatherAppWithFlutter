import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Weather/WeatherDetails.dart';

class FullDetailsWeatherPage extends StatelessWidget {
  final WeatherDetails _weatherDetails;

  FullDetailsWeatherPage(this._weatherDetails);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 20.0,
                ),
                child: Image.asset(
                  'images/london.png',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  '${_weatherDetails.weatherMoment}',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: 'TitilliumWeb-Light',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Wrap(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    hasNumber(_weatherDetails.weatherTime[0]) ==
                                            true
                                        ? Text('Time',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white))
                                        : Text(
                                            'Day Of the Week',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                          )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Wrap(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Icon',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                )),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Wrap(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Temp',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  )),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: 5.0),
                        child: Wrap(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Hum',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  )),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _weatherDetails.weatherDetailsLength,
                  itemBuilder: (context, index) {
                    print(
                        'lengthoflistview: ${_weatherDetails.weatherDetailsLength}');
                    return IndividualWeatherDetailsItem(
                      _weatherDetails.weatherTime[index],
                      _weatherDetails.weatherIcon[index],
                      _weatherDetails.weatherTemp[index],
                      _weatherDetails.weatherHumidity[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

bool hasNumber(String stringToCheck) {
  var regExpForNumber = RegExp('[0-9]');

  if (regExpForNumber.hasMatch(stringToCheck))
    return true;
  else
    return false;
}
