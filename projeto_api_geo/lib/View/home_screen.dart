import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart';
import 'favorites_screen.dart'; // Importe a tela de favoritos

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _getWeatherInit();
    _checkIfFavorite();
  }

  Future<void> _getWeatherInit() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      await _controller.getWeatherbyLocation(position.latitude, position.longitude);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkIfFavorite() async {
    String cityName = _controller.weatherList.isNotEmpty ? _controller.weatherList.last.name : '';
    bool isFavorite = await _dbService.isCityFavorite(cityName);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    String cityName = _controller.weatherList.isNotEmpty ? _controller.weatherList.last.name : '';
    bool isCurrentlyFavorite = await _dbService.isCityFavorite(cityName);

    setState(() {
      _isFavorite = !isCurrentlyFavorite;
    });

    if (isCurrentlyFavorite) {
      await _dbService.deleteCity(cityName);
    } else {
      City city = City(cityName: cityName, favoriteCities: 1);
      await _dbService.insertCity(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsão do Tempo"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
              child: Text("Ver Favoritos"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _getWeatherInit,
                  child: const Text("Atualizar"),
                ),
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : null,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _controller.weatherList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Erro ao obter dados de localização"),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: _getWeatherInit,
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text(_controller.weatherList.last.name),
                      const SizedBox(height: 10),
                      Text(_controller.weatherList.last.main),
                      const SizedBox(height: 10),
                      Text(_controller.weatherList.last.description),
                      const SizedBox(height: 10),
                      Text('${(_controller.weatherList.last.temp - 273).toStringAsFixed(2)}°C'),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: _getWeatherInit,
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
