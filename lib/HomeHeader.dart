import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageHeaderContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageHeaderContent();
}

//Initialize the location helper class
LocationHelper _locationHelper = LocationHelper();
String userCountry;
String userLocality;
double _longitude;
double _latitude;
int temp;
int humidity;
int wind;
int feelsLike;
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
    print('user address: Address');

    setState(() {
      isLocationLoading = false;
      userCountry = _locationHelper.userCountry;
      userLocality = _locationHelper.userLocality;
    });

    _longitude = _locationHelper.longitude;
    _latitude = _locationHelper.latitude;

    String urlForCurrentWeather =
        '$kBaseUrl/weather?lat=$_latitude&lon=$_longitude&appid=$kAppId&units=metric';

    NetworkHelper _networkHelper = NetworkHelper(url: urlForCurrentWeather);

    var weatherData = await _networkHelper.getData();

    setState(() {
      weatherIcon = getWeatherIcon(weatherData['weather'][0]['id']);
      var temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      tempDesc = weatherData['weather'][0]['description'];
      humidity = weatherData['main']['humidity'];
      var feelsLikeInDouble = weatherData['main']['feels_like'];
      feelsLike = feelsLikeInDouble.toInt();
      var windInDouble = weatherData['wind']['speed'];
      wind = windInDouble.toInt();
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

class WeatherExtrasContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            isCurrentWeatherLoading == true
                ? SpinKitHourGlass(
                    color: Colors.orange,
                  )
                : WeatherExtras(
                    title: 'Humidity',
                    value: '$humidity%',
                    icon: FontAwesomeIcons.rainbow,
                  ),
            isCurrentWeatherLoading == true
                ? SpinKitHourGlass(
                    color: Colors.orange,
                  )
                : WeatherExtras(
                    title: 'Wind',
                    value: '$wind mph',
                    icon: FontAwesomeIcons.wind,
                  ),
            isCurrentWeatherLoading == true
                ? SpinKitHourGlass(
                    color: Colors.orange,
                  )
                : WeatherExtras(
                    title: 'Feels Like',
                    value: '$feelsLike°C',
                    icon: FontAwesomeIcons.coffee,
                  ),
          ],
        ),
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
