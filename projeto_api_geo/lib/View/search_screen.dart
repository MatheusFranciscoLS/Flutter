import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text("Pesquisa Por Cidade"),
      ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _findCity(_cityController.text);
                        }
                      },
                      child: const Text("Search"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<City>>(
  future: _dbService.getAllCities().then((list) => list.map((e) => City.fromMap(e)).toList()),
  builder: (context, AsyncSnapshot<List<City>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Erro: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('Lista Vazia'));
    } else {
      List<City> cities = snapshot.data!;
      return ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return ListTile(
            title: Text(city.cityName),
            onTap: () {
              _findCity(city.cityName); // Chama _findCity com o nome da cidade
            },
          );
        },
      );
    }
  },
)

            ),
          ],
        ),
      ),
    );
  }

Future<void> _findCity(String cityName) async {
  if (await _controller.findCity(cityName)) {
    City city = City(cityName: cityName, favoriteCities: 0); // Cria a instância de City
    await _dbService.insertCity(city); // Insere a cidade no banco de dados
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cidade encontrada!"),
        duration: Duration(seconds: 1),
      ),
    );
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => DetailsWeatherScreen(city: cityName)),
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
