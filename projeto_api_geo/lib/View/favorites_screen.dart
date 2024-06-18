import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'package:projeto_api_geo/View/details_weather_screen.dart';

import '../Model/city_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final CityDataBaseService _dbService = CityDataBaseService();

  late List<City> _favoriteCities;

  @override
  void initState() {
    super.initState();
    _loadFavoriteCities();
  }

  Future<void> _loadFavoriteCities() async {
    List<City> cities = await _dbService.getAllCities();
    setState(() {
      _favoriteCities = cities.where((city) => city.historyCities).toList();
    });
  }

  Future<void> _removeFromFavorites(String cityName) async {
    await _dbService.historyCity(cityName, false);
    await _loadFavoriteCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidades Favoritas'),
      ),
      body: _favoriteCities.isEmpty
          ? const Center(child: Text('Nenhuma cidade favorita'))
          : ListView.builder(
              itemCount: _favoriteCities.length,
              itemBuilder: (context, index) {
                final city = _favoriteCities[index];
                return ListTile(
                  title: Text(city.cityName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsWeatherScreen(city: city.cityName),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeFromFavorites(city.cityName);
                    },
                  ),
                );
              },
            ),
    );
  }
}
