import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:flutter/material.dart';

class DashboardProfessor extends StatefulWidget {
  @override
  _DashboardProfessorState createState() => _DashboardProfessorState();
}

class _DashboardProfessorState extends State<DashboardProfessor> {

  final List alunos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua turma'),
      ),
      body: ListView(
        children: [
          AlunoCard('FULANE DA SILVE SOUZE'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AlunoForm()));
          setState(() {

          });
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class AlunoCard extends StatelessWidget {

  final String nome;

  AlunoCard(this.nome);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(8),
      child: Container(
        height: 40,
        child: Row(
          children: [
            Icon(Icons.add),
            Text(nome)
          ],
        ),
      ),
    );
  }
}
