class City {
  //atributos
  final String cityName;
  final bool historyCities;
  //construtor
  City({required this.cityName, required this.historyCities});
  // Métodos
  // toMap
  Map<String, dynamic> toMap() {
    return {
      'cityname': cityName,
      'historycities': historyCities,
    };
  }
   // fromMap
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['cityname'],
      historyCities: map['historycities'],
    );
  }
}