import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart'; // Importe o modelo de City

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final CityDataBaseService _dbService = CityDataBaseService();
  List<City> _favoriteCities = [];

  @override
  void initState() {
    super.initState();
    _getFavoriteCities();
  }

  Future<void> _getFavoriteCities() async {
    List<Map<String, dynamic>> citiesData = await _dbService.getAllCities();
    List<City> favorites = [];

    for (var cityData in citiesData) {
      if (cityData['favoriteCities'] == 1) {
        favorites.add(City.fromMap(cityData)); // Convertendo Map para City usando City.fromMap
      }
    }

    setState(() {
      _favoriteCities = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cidades Favoritas"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _favoriteCities.isEmpty
          ? Center(
              child: Text(
                "Nenhuma cidade favorita encontrada.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _favoriteCities.length,
              itemBuilder: (context, index) {
                final city = _favoriteCities[index];
                return ListTile(
                  title: Text(city.cityName),
                  onTap: () {
                    // Implemente ação ao clicar em uma cidade favorita, se necessário
                    // Por exemplo, navegar para a tela de detalhes usando Navigator
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsWeatherScreen(city: city.cityName),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
