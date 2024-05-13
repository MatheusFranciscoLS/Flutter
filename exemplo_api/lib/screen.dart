import 'package:flutter/material.dart';

import 'service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Instância do serviço WeatherService para obter os dados de previsão do tempo.
  final WeatherService _weatherService = WeatherService(
    apiKey:
        '681126f28e7d6fa3a7cfe0da0671e599', // Chave de API para acesso à API de previsão do tempo.
    baseUrl:
        'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  // Mapa que armazenará os dados de previsão do tempo.
  late Map<String, dynamic> _weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherData = new Map<String, dynamic>();
  }

  // Método assíncrono para buscar os dados de previsão do tempo para uma cidade específica.
  Future<void> _fetchWeatherData(String city) async {
    try {
      // Obtém os dados de previsão do tempo para a cidade especificada.
      final weatherData = await _weatherService.getWeather(city);
      // Atualiza o estado do widget com os novos dados de previsão do tempo.
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      // Em caso de erro ao buscar os dados de previsão do tempo, exibe uma mensagem de erro no console.
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
          child: FutureBuilder(
              future: _fetchWeatherData("Limeira"),
              builder: (context, snapshot) {
                if (_weatherData.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(
                            'City: ${_weatherData['name']}'), // Exibe o nome da cidade.
                        Text(
                            'Temperature: ${_weatherData['main']['temp'] - 273} °C'), // Exibe a temperatura em graus Celsius.
                        Text(
                            'Description: ${_weatherData['weather'][0]['description']}'), // Exibe a descrição do clima.
                      ]));
                }
              })),
    );
  }
}
