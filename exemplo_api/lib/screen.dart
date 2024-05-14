import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exemplo Weather-API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: "Digite o nome da cidade",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Insira o nome da cidade";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _fetchWeatherData(_cityController.text);
                  },
                  child: Text("Buscar"),
                ),
                SizedBox(height: 20),
                if (_weatherData.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'City: ${_weatherData['name']}',
                      ),
                      Text(
                        'Temperature: ${(_weatherData['main']['temp'] - 273).toStringAsFixed(2)} °C',
                      ),
                      Text(
                        'Description: ${_weatherData['weather'][0]['description']}',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
