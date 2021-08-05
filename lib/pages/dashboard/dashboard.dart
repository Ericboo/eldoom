import 'package:eldoom/models/user.dart';
import 'package:eldoom/pages/dashboard/aluno.dart';
import 'package:eldoom/pages/dashboard/professor.dart';
import 'package:flutter/material.dart';

//Dashboard é a tela que mostrará informações úteis tanto aos professores quanto
//aos alunos. A tela deverá saber se o login é referente a um professor ou aluno.
//ao aluno a tela deve mostrar as duas notas, a média e [talvez] os professores.
//ao professor a tela deve mostrar cada aluno em uma lista e permitir ao professor
//atribuir notas. good luck

class Dashboard extends StatelessWidget {
  final Usuario user;

  Dashboard(this.user);

  @override
  Widget build(BuildContext context) {
    return user.isAluno ? DashboardAluno(user) : DashboardProfessor();
  }
}


