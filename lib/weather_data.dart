import 'package:intl/intl.dart';
import 'package:weather_app/Constants/constants.dart';
import 'package:weather_app/Location/locationHelper.dart';
import 'package:weather_app/Networking/networking.dart';
import 'package:weather_app/Weather/weather.dart' as Weather;

class WeatherData {
  static List weatherForToday = [];
  static List weatherForTomorrow = [];
  static List weatherForWeek = [];
  static List<String> mDayOfTheWeekList = [];

  //Initialize the location helper class
  LocationHelper _locationHelper = LocationHelper();
  static String userCountry;
  static String userLocality;
  static double _longitude;
  static double _latitude;
  static int temp;
  static int humidity;
  static int wind;
  static int feelsLike;
  static String tempDesc;
  static String weatherIcon;
  static bool isLocationLoading = true;
  static bool isCurrentWeatherLoading = true;

  static List listOfWeatherData;

//  static List mListOfWeatherData;
  static String _time;
  static List<String> listOfTodayTime;
  static List<String> listOfTomorrowTime;
  static List<String> listOfWeatherIcon;
  static List<int> listOfWeatherTemp;
  static List<int> listOfWeatherHumidity;
  static bool isWeatherDataLoading = true;

  Future getUserAddressAndLocationData() async {
    await _locationHelper.getUserCountryAndLocality();

    userCountry = _locationHelper.userCountry;
    userLocality = _locationHelper.userLocality;
    isLocationLoading = false;

    _longitude = _locationHelper.longitude;
    _latitude = _locationHelper.latitude;

    String urlForCurrentWeather =
        '$kBaseUrl/weather?lat=$_latitude&lon=$_longitude&appid=$kAppId&units=metric';

    NetworkHelper _networkHelper = NetworkHelper(url: urlForCurrentWeather);

    var weatherData = await _networkHelper.getData();

    weatherIcon = Weather.getWeatherIcon(weatherData['weather'][0]['id']);
    var temperature = weatherData['main']['temp'];
    temp = temperature.toInt();
    tempDesc = weatherData['weather'][0]['description'];
    humidity = weatherData['main']['humidity'];
    var feelsLikeInDouble = weatherData['main']['feels_like'];
    feelsLike = feelsLikeInDouble.toInt();
    var windInDouble = weatherData['wind']['speed'];
    wind = windInDouble.toInt();
    isCurrentWeatherLoading = false;
  }

  Future getWeatherForecast() async {
    //Url to get weather forecast
    String weatherEndpoint =
        '$kBaseUrl/forecast?lat=${_locationHelper.latitude}&lon=${_locationHelper.longitude}&appid=$kAppId&units=metric';

    //Get json data from opeanweathermap.org
    NetworkHelper _networkHelper = NetworkHelper(url: weatherEndpoint);

    //To get the list of Weather Forecast
    var weatherData = await _networkHelper.getData();
    listOfWeatherData = weatherData['list'];

    //To initialize all variables.
//    mListOfWeatherData = List();
    listOfTodayTime = List();
    listOfTomorrowTime = List();
    listOfWeatherIcon = List();
    listOfWeatherTemp = List();
    listOfWeatherHumidity = List();

    //To wait for 'getting weather list' to be completed.
    await getWeatherList();

    //To notify that all weather data have been gotten so that we can remove the loading SpinKitHourGlass and show the data.
    isWeatherDataLoading = false;
  }

  Future getWeatherList() async {
    //To know what date, the date from the api should match.
    String dateToMatch;

    var dateForToday = DateTime.now().add(Duration(hours: 0)).toString();
    var dateForTomorrow = DateTime.now().add(Duration(hours: 24)).toString();

    //Variable to hold the time at 3:00 pm. To show each day of the week 3PM weather.

    //Regex to help match weather date. E.g 2020-05-02
    var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');

//    dateToMatch = regExpForDate.stringMatch(dateToMatch);
//
    //To loop through all weather data and get date from each of them. If it matches the current dateToMatch, add it to a new list. (It is this new list data we would show).

    for (int i = 0; i < listOfWeatherData.length; i++) {
      var dateToMatchForToday = regExpForDate.stringMatch(dateForToday);

      var matchesDate = listOfWeatherData[i]['dt_txt']
          .toString()
          .contains(dateToMatchForToday);

      if (matchesDate) {
        weatherForToday.add(listOfWeatherData[i]);
      }
    }
    for (int i = 0; i < listOfWeatherData.length; i++) {
      var dateToMatchForTomorrow = regExpForDate.stringMatch(dateForTomorrow);

      var matchesDate = listOfWeatherData[i]['dt_txt']
          .toString()
          .contains(dateToMatchForTomorrow);

      if (matchesDate) {
        weatherForTomorrow.add(listOfWeatherData[i]);
      }
    }
    for (int i = 0; i < listOfWeatherData.length; i++) {
      var matchesDate =
          listOfWeatherData[i]['dt_txt'].toString().contains('15:00');

      if (matchesDate) {
        weatherForWeek.add(listOfWeatherData[i]);
      }
    }
  }

  //To show the time in xAM OR xPM like 3AM, 12PM.
  static String getTimeForToday({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = weatherForToday[currentIndex]['dt_txt'];
    var timeMatch = regExp.stringMatch(_time);
    if (timeMatch == '00:00') {
      listOfTodayTime.add('12AM');
      return '12AM';
    } else if (timeMatch == '03:00') {
      listOfTodayTime.add('3AM');
      return '3AM';
    } else if (timeMatch == '06:00') {
      listOfTodayTime.add('6AM');
      return '6AM';
    } else if (timeMatch == '09:00') {
      listOfTodayTime.add('9AM');
      return '9AM';
    } else if (timeMatch == '12:00') {
      listOfTodayTime.add('12PM');
      return '12PM';
    } else if (timeMatch == '15:00') {
      listOfTodayTime.add('3PM');
      return '3PM';
    } else if (timeMatch == '18:00') {
      listOfTodayTime.add('6PM');
      return '6PM';
    } else if (timeMatch == '21:00') {
      listOfTodayTime.add('9PM');
      return '9PM';
    }
    return '';
  }

  static String getTimeForTomorrow({int currentIndex}) {
    RegExp regExp = RegExp('[0-9][0-9]:[0-9][0-9]');
    _time = weatherForTomorrow[currentIndex]['dt_txt'];
    var timeMatch = regExp.stringMatch(_time);
    if (timeMatch == '00:00') {
      listOfTomorrowTime.add('12AM');
      return '12AM';
    } else if (timeMatch == '03:00') {
      listOfTomorrowTime.add('3AM');
      return '3AM';
    } else if (timeMatch == '06:00') {
      listOfTomorrowTime.add('6AM');
      return '6AM';
    } else if (timeMatch == '09:00') {
      listOfTomorrowTime.add('9AM');
      return '9AM';
    } else if (timeMatch == '12:00') {
      listOfTomorrowTime.add('12PM');
      return '12PM';
    } else if (timeMatch == '15:00') {
      listOfTomorrowTime.add('3PM');
      return '3PM';
    } else if (timeMatch == '18:00') {
      listOfTomorrowTime.add('6PM');
      return '6PM';
    } else if (timeMatch == '21:00') {
      listOfTomorrowTime.add('9PM');
      return '9PM';
    }
    return '';
  }

  //To get weather temperature.
  static int getTemp({List weatherList, int currentIndex}) {
    var temperature = weatherList[currentIndex]['main']['temp'];
    var _temp = temperature.toInt();
    listOfWeatherTemp.add(_temp);
    return _temp;
  }

  //To get weather icon.
  static String getWeatherIcon({List weatherList, int currentIndex}) {
    var weatherCondition = weatherList[currentIndex]['weather'][0]['id'];
    listOfWeatherIcon.add(Weather.getWeatherIcon(weatherCondition));
    return Weather.getWeatherIcon(weatherCondition);
  }

  //If the 'dateToMatch' is for weekly weather, this is the function to get each day of the week.
  static String getDayOfWeek({int currentIndex}) {
    var currentDateTime = DateTime.now();
    var dayOfTheWeekFormat = DateFormat('EEEE');

    for (int i = 1; i <= 5; i++) {
      mDayOfTheWeekList.add(
        dayOfTheWeekFormat.format(
          currentDateTime.add(
            Duration(days: i),
          ),
        ),
      );
    }

    return mDayOfTheWeekList[currentIndex].substring(0, 3);
  }

  //To get weather humidity.
  static void getWeatherHumidity({List weatherList, int currentIndex}) {
    var weatherHumidity = weatherList[currentIndex]['main']['humidity'];

    listOfWeatherHumidity.add(weatherHumidity);
  }
}
