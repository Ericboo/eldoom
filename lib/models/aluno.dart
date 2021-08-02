import 'package:firebase_database/firebase_database.dart';

Aluno novoAluno(values) {

  final Map<String, dynamic> novoAluno = {
    'nome': '',
    'email': '',
    'senha': '',
    'nota1': -1.0,
    'nota2': -1.0,
  };
  values.forEach((key, value) {
    novoAluno[key] = value;
  });

  return new Aluno(novoAluno['nome'], novoAluno['email'],
      novoAluno['senha'], double.parse(novoAluno['nota1'].toString()),
      double.parse(novoAluno['nota2'].toString()));
}

class Aluno {
  late DatabaseReference _id;
  final String nome;
  final String email;
  final String senha;
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
    };
  }

  Aluno(this.nome, this.email, this.senha, this.nota1, this.nota2);
}
