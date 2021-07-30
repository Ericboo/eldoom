import 'package:flutter/material.dart';

//Dashboard é a tela que mostrará informações úteis tanto aos professores quanto
//aos alunos. A tela deverá saber se o login é referente a um professor ou aluno.
//ao aluno a tela deve mostrar as duas notas, a média e [talvez] os professores.
//ao professor a tela deve mostrar cada aluno em uma lista e permitir ao professor
//atribuir notas. good luck

class Dashboard extends StatelessWidget {
  final bool aluno = false;

  @override
  Widget build(BuildContext context) {
    return aluno ? DashboardAluno() : DashboardProfessor();
  }
}

class DashboardAluno extends StatelessWidget {
  final double nota1 = 8;
  final double nota2 = 10;

  @override
  Widget build(BuildContext context) {
    final double median = (nota1 + nota2) / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Neste perido, suas notas foram:", style: TextStyle(fontSize: 16),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        //TODO: verificar se existem as notas antes de mostrá-las.
                        padding: EdgeInsets.all(16),
                        child: Text(nota1.toString() + " e " + nota2.toString(), style: TextStyle(fontSize: 32, color: Colors.white),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Text("Neste perido, sua média é:", style: TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(median.toString(), style: TextStyle(fontSize: 32, color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: 50,
                child: Center(
                    child: Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}
