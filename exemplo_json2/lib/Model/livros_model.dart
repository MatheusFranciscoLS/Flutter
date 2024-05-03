class Livro {
  //atributos
  final String titulo;
  final String autor;
  final String sinopse;
  final String categoria;
  final int isbn;
  final String capa;

  //construtor
  Livro(
      {required this.titulo,
      required this.autor,
      required this.sinopse,
      required this.categoria,
      required this.isbn,
      required this.capa});
  //métodos (mapeamento)
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'sinopse': sinopse,
      'categoria': categoria,
      'isbn': isbn,
      'capa': capa,
    };
  }

  factory Livro.fromJson(Map<String, dynamic> map) {
    return Livro(
      titulo: map['titulo'],
      autor: map['autor'],
      sinopse: map['sinopse'],
      categoria: map['categoria'],
      isbn: map['isbn'],
      capa: map['capa'],
    );
  }
}
