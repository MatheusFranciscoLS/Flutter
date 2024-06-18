import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

import '../Model/city_model.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDataBaseService _dbService = CityDataBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Insira a Cidade"),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Insira a Cidade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _findCity(_cityController.text);
                        }
                      },
                      child: const Text("Pesquisar"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<City>>(
                future: _dbService.getAllCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Erro ao carregar histórico"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Sem Histórico"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final city = snapshot.data![index];
                        return ListTile(
                          title: Text(city.cityName),
                          onTap: () {
                            _findCity(city.cityName);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _findCity(String city) async {
  if (await _controller.findCity(city)) {
    List<City> cities = await _dbService.getAllCities();
    bool cityExists = cities.any((c) => c.cityName == city && c.historyCities);
    if (!cityExists) {
      City cidade = City(cityName: city, historyCities: true);
      await _dbService.insertCity(cidade);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade encontrada e adicionada ao histórico!"),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade já está no histórico!"),
          duration: Duration(seconds: 1),
        ),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => DetailsWeatherScreen(city: city),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cidade não encontrada!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

}
