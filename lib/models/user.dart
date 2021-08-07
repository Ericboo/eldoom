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
    novoValor[i] = novoValor[i].replaceAll('{','');
    novoValor[i] = novoValor[i].replaceAll('}','');
    var insert = novoValor[i].split(':');
    if (insert[0].trim() == 'isAluno') {
      if (insert[1].trim() == "true") {
        novoUser['isAluno'] = true;
      } else {
        novoUser['isAluno'] = false;
      }
      continue;
    }
    novoUser[insert[0].trim()] = insert[1].trim().trim();
  }
  return new Usuario(
      novoUser['nome'],
      novoUser['credential'],
      double.parse(novoUser['nota1'].toString()),
      double.parse(novoUser['nota2'].toString()),
      novoUser['isAluno'],
  );
}

class Usuario {

  final String credential;
  final String nome;
  final bool isAluno;
  double nota1;
  double nota2;


  String getId() {
    return this.credential;
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
