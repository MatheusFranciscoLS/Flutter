import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _controller = WeatherController();

  @override
  void initState() {
    super.initState();
    _getWeatherInit();
  }

  Future<void> _getWeatherInit() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      _controller.getWeatherByLocation(position.latitude, position.longitude);
      setState(() {});
    } catch (e) {
      print(e);
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
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),          IconButton(
            icon: const Icon(Icons.favorite_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _controller.weatherList.isEmpty
                ? Row(
                    children: [
                      const Text("Erro de Conexão"),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          _getWeatherInit();
                        },
                      )
                    ],
                  )
                : Column(
                    children: [
                      Text(_controller.weatherList.last.name),
                      const SizedBox(height: 10),
                      Text(_controller.translateMain(_controller.weatherList.last.main)),
                      const SizedBox(height: 10),
                      Text(_controller.translateDescription(_controller.weatherList.last.description)), // Aqui chamamos o método de tradução
                      const SizedBox(height: 10),
                      Text((_controller.weatherList.last.temp - 273).toStringAsFixed(2)),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          _getWeatherInit();
                        },
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
