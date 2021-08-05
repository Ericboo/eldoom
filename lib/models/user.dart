import 'package:firebase_database/firebase_database.dart';

Usuario novoUser(values) {
  final Map<String, dynamic> novoUser = {
    'nome': '',
    'credential': '',
    'nota1': -1.0,
    'nota2': -1.0,
    'isAluno': true,
  };
  values.forEach((key, value) {
    novoUser[key] = value;
  });

  return new Usuario(
      novoUser['nome'],
      novoUser['credential'],
      double.parse(novoUser['nota1'].toString()),
      double.parse(novoUser['nota2'].toString()),
      novoUser['isAluno']);
}

class Usuario {

  late DatabaseReference _id;
  final String credential;
  final String nome;
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
      'credential': this.credential,
      'nota1': this.nota1,
      'nota2': this.nota2,
      'isAluno': this.isAluno,
    };
  }

  Usuario(this.nome, this.credential, this.nota1, this.nota2, this.isAluno);
}
