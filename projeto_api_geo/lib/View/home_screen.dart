import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _controller = WeatherController();

  Future<void> _getWeatherInit() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      await _controller.getWeatherbyLocation(position.latitude, position.longitude);
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
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: const Text("Pesquisar"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Favoritos"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<void>(
              future: _getWeatherInit(),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(_controller.weatherList.last.name),
                    const SizedBox(height: 10),
                    Text(_controller.weatherList.last.main),
                    const SizedBox(height: 10),
                    Text(_controller.weatherList.last.description),
                    const SizedBox(height: 10),
                    Text((_controller.weatherList.last.temp - 273).toStringAsFixed(2)),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _getWeatherInit,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
