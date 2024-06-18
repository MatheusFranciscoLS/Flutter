class Weather {
  // Atributos da classe Weather
  final String name;         // Nome da cidade
  final String main;         // Condição climática principal
  final String description;  // Descrição da condição climática
  final double temp;         // Temperatura atual
  final double tempMax;      // Temperatura máxima
  final double tempMin;      // Temperatura mínima

  // Construtor da classe Weather
  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.temp,
    required this.tempMax,
    required this.tempMin
  });

  // Método factory para criar uma instância de Weather a partir de um mapa json
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],                               // Obtém o nome da cidade
      main: json['weather'][0]['main'],                 // Obtém a condição climática principal
      description: json['weather'][0]['description'],   // Obtém a descrição da condição climática
      temp: json['main']['temp'],                       // Obtém a temperatura atual
      tempMax: json['main']['temp_max'],                // Obtém a temperatura máxima
      tempMin: json['main']['temp_min']                 // Obtém a temperatura mínima
    );
  }
}
