class WeatherModel {
  String weatherDesc;
  double temp;
  double wind;
  double feelsLike;
  int humidity;
  int weatherId;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : this.weatherDesc = json['weather'][0]['description'],
        this.temp = json['main']['temp'],
        this.wind = json['wind']['speed'],
        this.feelsLike = json['main']['feels_like'],
        this.humidity = json['main']['humidity'],
        this.weatherId = json['weather'][0]['id'];
}
