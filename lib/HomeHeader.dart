import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart';

class HomePageHeaderContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageHeaderContent();
}

//Initialize the location helper class
LocationHelper _locationHelper = LocationHelper();
String userCountry;
String userLocality;
double longitude;
double latitude;
int temp;
String tempDesc;
String weatherIcon;
bool isLocationLoading = true;
bool isCurrentWeatherLoading = true;

class _HomePageHeaderContent extends State<HomePageHeaderContent> {
  @override
  void initState() {
    super.initState();
    getUserAddressAndLocationData();
  }

  //To get User's Country, Locality and current weather info.
  Future getUserAddressAndLocationData() async {
    await _locationHelper.getUserCountryAndLocality();
    print('User locality: $userLocality');
    setState(() {
      userCountry = _locationHelper.userCountry;
      userLocality = _locationHelper.userLocality;
      isLocationLoading = false;
    });

    longitude = _locationHelper.longitude;
    latitude = _locationHelper.latitude;

    String url =
        '$kBaseUrl/weather?lat=$latitude&lon=$longitude&appid=$kAppId&units=metric';

    NetworkHelper _networkHelper = NetworkHelper(url: url);

    var weatherData = await _networkHelper.getData();

    setState(() {
      var temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      tempDesc = weatherData['weather'][0]['description'];
      weatherIcon = getWeatherIcon(weatherData['weather'][0]['id']);
      isCurrentWeatherLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LocationLabel(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isLocationLoading == true
                      ? SpinKitHourGlass(
                          color: Colors.orange,
                        )
                      : LocationRichText(),
                  Icon(Icons.share, color: Colors.white)
                ],
              ),
              isCurrentWeatherLoading == true
                  ? SpinKitHourGlass(
                      color: Colors.orange,
                    )
                  : CurrentWeatherInfo(),
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
        text: '$userLocality\n',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$userCountry',
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
class CurrentWeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '$weatherIcon',
              style: TextStyle(fontSize: 60.0),
            ),
            SizedBox(width: 10.0),
            Text(
              '$temp°C',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
              ),
            )
          ],
        ),
        Text(
          '$tempDesc',
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
//
//return Padding(
//padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//isLocationLoading == true
//? SpinKitChasingDots(
//color: Colors.orange,
//)
//: LocationRichText(),
//Icon(
//Icons.share,
//color: Colors.white,
//),
//],
//),
//Align(
//alignment: Alignment.centerLeft,
//child: SpinKitRotatingPlain(
//color: Colors.orange,
//),
//),
//],
//),
//);
