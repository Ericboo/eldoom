import 'package:flutter/material.dart';

//Dashboard é a tela que mostrará informações úteis tanto aos professores quanto
//aos alunos. A tela deverá saber se o login é referente a um professor ou aluno.
//ao aluno a tela deve mostrar as duas notas, a média e os professores.
//ao professor a tela deve mostrar cada aluno em uma lista e permitir ao professor
//atribuir notas em outro formulário. good luck

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}
