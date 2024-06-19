import 'package:flutter/material.dart';

import '../Service/weather_service_api.dart';
import '../Model/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherController {
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];

  List<Weather> get weatherList => _weatherList;

  Future<void> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getWeatherByLocation(double lat, double lon) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeatherByLocation(lat, lon));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> findCity(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String translateMain(String main) {
    switch (main.toLowerCase()) {
      case 'clear':
        return 'limpo';
      case 'clouds':
        return 'nublado';
      case 'rain':
        return 'chuva';
      case 'drizzle':
        return 'chuvisco';
      case 'thunderstorm':
        return 'trovoada';
      case 'snow':
        return 'neve';
      case 'mist':
        return 'névoa';
      default:
        return main;
    }
  }

  String translateDescription(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'céu limpo';
      case 'few clouds':
        return 'poucas nuvens';
      case 'scattered clouds':
        return 'nuvens esparsas';
      case 'broken clouds':
        return 'céu nublado';
      case 'shower rain':
        return 'chuvisco';
      case 'rain':
        return 'chuva';
      case 'thunderstorm':
        return 'trovoada';
      case 'snow':
        return 'neve';
      case 'mist':
        return 'névoa';
      default:
        return description;
    }
  }

 IconData getWeatherIcon(String main) {
    switch (main.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'clouds':
        return WeatherIcons.cloud;
      case 'rain':
        return WeatherIcons.rain;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
        return WeatherIcons.fog;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      default:
        return WeatherIcons.na;
    }
  }

Color getIconColor(double temp) {
  // Retorna a cor  se a temperatura for menor que 10
  if (temp < 10) {
    return Colors.blue;
  } 
  // Retorna a cor  se a temperatura for maior ou igual a 10 e menor que 20
  else if (temp >= 10 && temp < 20) {
    return Color.fromARGB(255, 238, 222, 4);
  } 
  // Retorna a cor  para qualquer outra temperatura
  else {
    return Colors.red;
  }
}


}
