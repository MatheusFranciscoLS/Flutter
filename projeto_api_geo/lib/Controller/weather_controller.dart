import '../Service/weather_service_api.dart';
import '../Model/weather_model.dart';

class WeatherController {
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];

  List<Weather> get weatherList => _weatherList;

  Future<Weather> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      _weatherList.add(weather);
      return weather;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<void> getWeatherbyLocation(double lat, double lon) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeatherByLocation(lat, lon));
      _weatherList.add(weather);
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<bool> findCity(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      _weatherList.add(weather);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
