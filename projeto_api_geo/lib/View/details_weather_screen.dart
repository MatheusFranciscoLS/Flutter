import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> with SingleTickerProviderStateMixin {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool isHistory = false;

  @override
  void initState() {
    super.initState();
    checkIfHistory();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkIfHistory() async {
    List<City> cities = await _dbService.getAllCities();
    setState(() {
      isHistory = cities.any((city) => city.cityName == widget.city && city.historyCities);
    });
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
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: child,
              );
            },
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
                  Color iconColor = _controller.getIconColor(weather.temp - 273); // Obtém a cor do ícone do controller
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(
                          iconData,
                          size: 60,
                          color: iconColor, // Usa a cor obtida do controller
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
      ),
    );
  }
}
