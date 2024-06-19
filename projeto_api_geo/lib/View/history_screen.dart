import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'details_weather_screen.dart';
import '../Model/city_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final CityDataBaseService _dbService = CityDataBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<City>>(
          future: _dbService.getAllCities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar cidades favoritas"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Sem cidades favoritas"));
            } else {
              // Remover duplicatas e ordenar a lista de cidades por ordem alfabética
              List<City> sortedCities = snapshot.data!.toSet().toList();
              sortedCities.sort((a, b) => a.cityName.compareTo(b.cityName));

              return ListView.builder(
                itemCount: sortedCities.length,
                itemBuilder: (context, index) {
                  final city = sortedCities[index];
                  return ListTile(
                    title: Text(city.cityName),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _dbService.removeCityFromHistory(city.cityName);
                        setState(() {}); // Atualiza a tela após a remoção
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailsWeatherScreen(city: city.cityName),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
