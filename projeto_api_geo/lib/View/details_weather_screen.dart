import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();
  late bool isFavorite = false; // Inicializa com false por padrão

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    bool favorite = await _dbService.isCityFavorite(widget.city);
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> toggleFavorite() async {
    try {
      bool currentFavorite = await _dbService.isCityFavorite(widget.city);
      if (currentFavorite) {
        await _dbService.historyCity(widget.city, false); // Remove dos favoritos
      } else {
        City city = City(cityName: widget.city, historyCities: true);
        await _dbService.insertCity(city); // Adiciona aos favoritos
      }
      setState(() {
        isFavorite = !currentFavorite; // Atualiza o estado do ícone de favoritos
      });
    } catch (e) {
      print(e);
      // Trate qualquer erro de banco de dados aqui, se necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder(
            future: _controller.getWeather(widget.city),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                final weather = _controller.weatherList.last;
                IconData iconData = _controller.getWeatherIcon(weather.main);
                Color iconColor = _controller.getIconColor(weather.temp - 273);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Icon(
                        iconData,
                        size: 60,
                        color: iconColor,
                      ),
                    ),
                    Text(weather.name),
                    const SizedBox(height: 10),
                    Text(_controller.translateMain(weather.main)),
                    Text(_controller.translateDescription(weather.description)),
                    Text((weather.temp - 273).toInt().toString()),
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
