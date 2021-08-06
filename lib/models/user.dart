import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

Usuario novoUser(values) {

  final Map<String, dynamic> novoUser = {
    'nome': '',
    'credential': '',
    'nota1': -1.0,
    'nota2': -1.0,
    'isAluno': true,
  };

  List<String> novoValor = values.toString().split(',');
  for (var i = 0; i < novoValor.length; i++) {
    if (novoValor[i].trim().startsWith('{nota1')) {
      novoUser['nota1'] = double.tryParse(novoValor[i].substring(8));
    } else if (novoValor[i].trim().startsWith('nota2')) {
      novoUser['nota2'] = double.tryParse(novoValor[i].substring(8));
    } else if (novoValor[i].trim().startsWith('nome')) {
      novoUser['nome'] = novoValor[i].substring(6, novoValor[i].length - 1).trim();
    } else if (novoValor[i].trim().startsWith('isAluno')) {
      if (novoValor[i].substring(9).trim() == "true") {
        novoUser['isAluno'] = true;
      } else {
        novoUser['isAluno'] = false;
      }
    } else if (novoValor[i].trim().startsWith('credential')) {
      novoUser['credential'] = novoValor[i].substring(12).trim();
    }
  }

  return new Usuario(
      novoUser['nome'],
      novoUser['credential'],
      double.parse(novoUser['nota1'].toString()),
      double.parse(novoUser['nota2'].toString()),
      novoUser['isAluno']);
}

class Usuario {

  late final String credential;
  final String nome;
  final bool isAluno;
  double nota1;
  double nota2;


  String getId() {
    return this.credential;
  }

  void setId(credential) {
    this.credential = credential;
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
