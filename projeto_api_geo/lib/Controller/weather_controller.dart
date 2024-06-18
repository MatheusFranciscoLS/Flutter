import '../Service/weather_service_api.dart';
import '../Model/weather_model.dart';

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
}


