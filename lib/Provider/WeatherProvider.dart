import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class WeatherProvider extends ChangeNotifier {
  static final WeatherProvider _singleton = WeatherProvider.createInstance();
  WeatherProvider.createInstance();

  factory WeatherProvider() {
    return _singleton;
  }

  int _wind;
  int _humidity;
  int _feelsLike;
  int _currentTemp;
  String _userCountry;
  String _weatherIcon;
  String _weatherDesc;
  String _userLocality;

  int get wind => _wind;
  int get humidity => _humidity;
  int get feelsLike => _feelsLike;
  int get currentTemp => _currentTemp;
  String get weatherDesc => _weatherDesc;
  String get userCountry => _userCountry;
  String get weatherIcon => _weatherIcon;
  String get userLocality => _userLocality;

  setUserCountry(String userCountry) {
    this._userCountry = userCountry;
    notifyListeners();
  }

  setUserLocality(String userLocality) {
    this._userLocality = userLocality;
    notifyListeners();
  }

  setCurrentTemp(int currentTemp) {
    this._currentTemp = currentTemp;
    notifyListeners();
  }

  setWeatherDesc(String weatherDesc) {
    this._weatherDesc = weatherDesc;
    notifyListeners();
  }

  setHumidity(int humidity) {
    this._humidity = humidity;
    notifyListeners();
  }

  setWind(int wind) {
    this._wind = wind;
    notifyListeners();
  }

  setFeelsLike(int setFeelsLike) {
    this._feelsLike = setFeelsLike;
    notifyListeners();
  }

  setWeatherIcon(String icon) {
    this._weatherIcon = icon;
    notifyListeners();
  }
}
