// weather_model.dart

class Weather {
  final String name;
  final String main;
  final String description;
  final double temp;
  final double tempMax;
  final double tempMin;

  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
    );
  }
}
