import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey: 'b9ebe666087f299f5e2aad3a03d093b6',
    baseUrl: 'https://api.openweathermap.org/data/2.5',
  );

  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _weatherData = {};

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchWeatherLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final weatherData = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  String _translateDescription(String description) {
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
        return 'chuva de banho';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exemplo Weather-API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: _fetchWeatherLocation(),
          builder: (context, snapshot) {
            if (_weatherData.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cidade: ${_weatherData['name']}',
                    ),
                    Text(
                      'Temperatura: ${(_weatherData['main']['temp'] - 273.15).toInt()} °C',
                    ),
                    Text(
                      'Descrição: ${_translateDescription(_weatherData['weather'][0]['description'])}',
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
