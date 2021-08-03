import 'package:firebase_database/firebase_database.dart';

User novoUser(values) {
  final Map<String, dynamic> novoUser = {
    'nome': '',
    'email': '',
    'senha': '',
    'nota1': -1.0,
    'nota2': -1.0,
    'isAluno': true,
  };
  values.forEach((key, value) {
    novoUser[key] = value;
  });

  return new User(
      novoUser['nome'],
      novoUser['email'],
      novoUser['senha'],
      double.parse(novoUser['nota1'].toString()),
      double.parse(novoUser['nota2'].toString()),
      novoUser['isAluno']);
}

class User {
  late DatabaseReference _id;
  final String nome;
  final String email;
  final String senha;
  final bool isAluno;
  double nota1;
  double nota2;

  void setId(DatabaseReference id) {
    this._id = id;
  }

  DatabaseReference getId() {
    return this._id;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': this.nome,
      'email': this.email,
      'senha': this.senha,
      'nota1': this.nota1,
      'nota2': this.nota2,
      'isAluno': this.isAluno,
    };
  }

  User(this.nome, this.email, this.senha, this.nota1, this.nota2, this.isAluno);
}
