import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:flutter/material.dart';
import 'package:eldoom/web_api/firebase_connection.dart';

class DashboardProfessor extends StatefulWidget {
  @override
  _DashboardProfessorState createState() => _DashboardProfessorState();
}

class _DashboardProfessorState extends State<DashboardProfessor> {
  final List<dynamic> _nota1 = [];
  final List<dynamic> _nota2 = [];
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
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
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
                                            _nota1.removeAt(index);
                                            _nota2.removeAt(index);
                                          });
                                        }),
                                    Expanded(child: Text(alunos[index].nome)),
                                    NotaForm(_nota1),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    NotaForm(_nota2),
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
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Subir as notas',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    final Future future = Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AlunoForm()));
                    await future.then((novoAluno) {
                      if (novoAluno == null) {
                        return;
                      }
                      novoAluno.setId(saveUser(novoAluno));
                      alunos.add(novoAluno);
                    });
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Adicionar novo aluno',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class NotaForm extends StatelessWidget {
  List<dynamic> _controller;

  NotaForm(this._controller);

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
          onChanged: (_nota1) {
            print(_controller.text);
          },
          controller: _controller,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
