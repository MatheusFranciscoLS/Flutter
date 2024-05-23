import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

import '../Controller/weather_controller.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDataBaseService _dbService = CityDataBaseService();
  List<City> _cityList =  [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cityList = _dbService.getAllCities() as List<City>;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Insira a Cidade"),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Insira a Cidade";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _findCity(_cityController.text);
                      }
                    },
                    child: const Text("Pesquisar"),
                  ),
                  FutureBuilder(
                    future: _dbService.getAllCities(), 
                    builder: (context,snapshot){
                      if(_cityList.isEmpty){
                        return const Text("");
                      }else{
                        return ListView.builder(
                          itemBuilder: _cityList,
                          itemCount: _cityList.length,
                          child: ListTile(
                            title:

                          )
                          );

                      }
                    })
                ]))),
      ),
    );
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      //snackbar
      City cidade = City(cityName: city, favoriteCities: false);
      _dbService.insertCity(cidade);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  DetailsWeatherScreen(city: city)));
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
