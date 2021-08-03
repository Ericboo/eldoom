import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eldoom/web_api/firebase_connection.dart';

class DashboardProfessor extends StatefulWidget {
  @override
  _DashboardProfessorState createState() => _DashboardProfessorState();
}

class _DashboardProfessorState extends State<DashboardProfessor> {
  List<dynamic> alunos = [];

  void updateAlunos() {
    getUser().then((value) => {
      this.setState(() {
        this.alunos = value;
      }),
    });
  }

  @override
  void initState() {
    super.initState();
    updateAlunos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua turma'),
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              alunos = snapshot.data as List<dynamic>;
              //updateAlunos();
              return ListView.builder(
                  itemCount: alunos.length,
                  itemBuilder: (context, index) {
                    if (alunos[index].isAluno == false) {
                      return Container();
                    }
                    return Column(
                      children: [
                        Card(
                          color: Theme.of(context).primaryColor,
                          margin: EdgeInsets.all(8),
                          child: Container(
                            height: 40,
                            child: Row(
                              children: [
                                InkWell(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red[400],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        deleteUser(alunos[index]);
                                        alunos.removeAt(index);
                                      });
                                    }),
                                Expanded(child: Text(alunos[index].nome)),
                                NotaForm(),
                                SizedBox(
                                  width: 16,
                                ),
                                NotaForm(),
                                SizedBox(
                                  width: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });

            case ConnectionState.none:
              return Text('Unexpected error');

            case ConnectionState.active:
              return Text('Unexpected error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Future future = Navigator.push(
              context, MaterialPageRoute(builder: (context) => AlunoForm()));
          await future.then((novoAluno) {
            if (novoAluno == null) {
              return;
            }
            novoAluno.setId(saveUser(novoAluno));
            alunos.add(novoAluno);
          });
          setState(() {});
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
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
