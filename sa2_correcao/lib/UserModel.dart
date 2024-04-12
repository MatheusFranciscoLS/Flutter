class User {
  String nome;
  String email;
  String senha;

  User({required this.nome, required this.email, required this.senha});

    factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  // Método para converter o usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }
}