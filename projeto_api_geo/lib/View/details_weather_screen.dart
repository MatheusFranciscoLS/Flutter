// details_weather_screen.dart

import 'package:flutter/material.dart';
import '../Controller/weather_controller.dart';
import '../Model/weather_model.dart';
import '../Service/city_db_service.dart';
import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;

  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  _DetailsWeatherScreenState createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool isFavorite = await _dbService.isCityFavorite(widget.city);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      await _dbService.insertCity(City(cityName: widget.city, favoriteCities: 1));
    } else {
      await _dbService.deleteCity(widget.city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder<Weather>(
            future: _controller.getWeather(widget.city),
            builder: (context, AsyncSnapshot<Weather> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('Dados não encontrados');
              } else {
                var weatherData = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weatherData.name),
                        IconButton(
                          icon: _isFavorite
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          onPressed: _toggleFavorite,
                        ),
                      ],
                    ),
                    Text(weatherData.main),
                    Text(weatherData.description),
                    Text('${(weatherData.temp - 273.15).toStringAsFixed(2)}°C'),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
