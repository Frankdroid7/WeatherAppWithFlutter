import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Model/WeatherModel.dart';
import 'package:weather_app/Model/WeatherModelList.dart';
import 'package:weather_app/UI/CustomWidgets/IndividualDetailListItem.dart';

class FullDetailsWeatherPage extends StatelessWidget {
  final WeatherModelList _weatherDetails;

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
                    Material(
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        focusColor: Colors.green,
                        icon: Icon(Icons.arrow_back, color: Colors.red),
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.purple,
                      ),
                    )
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
                                                fontSize: 15.0,
                                                color: Colors.white))
                                        : Text(
                                            'Day Of the Week',
                                            style: TextStyle(
                                                fontSize: 15.0,
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
                                      fontSize: 15.0, color: Colors.white),
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
                                        fontSize: 15.0, color: Colors.white),
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
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Hum',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                )),
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

bool hasNumber(String stringToCheck) {
  var regExpForNumber = RegExp('[0-9]');

  if (regExpForNumber.hasMatch(stringToCheck))
    return true;
  else
    return false;
}
