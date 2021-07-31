import 'package:eldoom/models/aluno.dart';
import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:flutter/material.dart';

class DashboardProfessor extends StatefulWidget {
  @override
  _DashboardProfessorState createState() => _DashboardProfessorState();
}

class _DashboardProfessorState extends State<DashboardProfessor> {

  final List<dynamic> alunos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua turma'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              AlunoCard(alunos[index]),
            ],
          );
        },
        itemCount: alunos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) => AlunoForm()));
          await future.then((novoAluno) {
            alunos.add(novoAluno);
          });
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

  final Aluno aluno;

  AlunoCard(this.aluno);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(8),
      child: Container(
        height: 40,
        child: Row(
          children: [
            Icon(Icons.close, color: Colors.red[400],),
            Expanded(child: Text(aluno.nome)),
            NotaForm(),
            SizedBox(width: 16,),
            NotaForm(),
            SizedBox(width: 12,)
          ],
        ),
      ),
    );
  }
}

class NotaForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: TextField(
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
