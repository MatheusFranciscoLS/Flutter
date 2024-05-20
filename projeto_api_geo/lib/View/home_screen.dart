import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Service/weather_service_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _weatherData = {};
  WeatherService _weatherService = new WeatherService();
  @override
  void initState() {
    super.initState();
    _getWeatherInit();
  }

  Future<void> _getWeatherInit() async {
    try {

      Position position = await Geolocator.getCurrentPosition();
      
      print(position.latitude);
      _weatherData = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);
      setState(() {});
      print("Localização ok");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsão do tempo"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Favoritos")),
                ElevatedButton(onPressed: () {}, child: Text("Pesquisar")),
                ElevatedButton(onPressed: () {}, child: Text("Ajuda"))
              ],
            ),
            const SizedBox(height: 20),
            _weatherData.isEmpty
                ? Row(
                    children: [
                      Text('Erro de Conexão'),
                      IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            _getWeatherInit();
                          })
                    ],
                  )
                : Column(
                    children: [
                      Text(_weatherData['name']),
                      const SizedBox(height: 10),
                      Text(_weatherData['weather'][0]['description']),
                      const SizedBox(height: 10),
                      Text(_weatherData['weather'][0]['main']),
                      const SizedBox(height: 10),
                      Text(_weatherData['weather'][0]['icon']),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
