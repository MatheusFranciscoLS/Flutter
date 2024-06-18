// city_model.dart

class City {
  final String cityName;
  final int favoriteCities;

  City({required this.cityName, required this.favoriteCities});

  Map<String, dynamic> toMap() {
    return {
      'cityname': cityName,
      'favoritecities': favoriteCities,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['cityname'],
      favoriteCities: map['favoritecities'],
    );
  }
}
