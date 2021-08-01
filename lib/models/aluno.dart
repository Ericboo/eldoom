import 'package:firebase_database/firebase_database.dart';

class Aluno {
  late DatabaseReference _id;
  final String nome;
  final String email;
  final String senha;
  double? nota1;
  double? nota2;

  void setId(DatabaseReference id) {
    this._id = id;
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

  Aluno(this.nome, this.email, this.senha, {this.nota1, this.nota2});
}
