import 'package:eldoom/models/user.dart';
import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:flutter/material.dart';
import 'package:eldoom/web_api/firebase_connection.dart';
import 'package:flutter/services.dart';

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
                  return RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(Duration(milliseconds: 400), () {
                        setState(() {
                          updateAlunos();
                        });
                      });
                    },
                    child: ListView.builder(
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
                                      NotaForm(true, alunos[index]),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      NotaForm(false, alunos[index]),
                                      SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  );

                case ConnectionState.none:
                  return Text('Unexpected error');

                case ConnectionState.active:
                  return Text('Unexpected error');
              }
            },
          ),
        ),
      ]),
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
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

class NotaForm extends StatelessWidget {
  final bool isNota1;
  final TextEditingController _controller = TextEditingController();
  final User aluno;

  NotaForm(this.isNota1, this.aluno);

  void setNota(String value) {
    double? nota = double.tryParse(_controller.text);
    if (nota == null) {
      nota = -1.0;
    }
    if (isNota1) {
      aluno.nota1 = nota;
      updateUser(aluno);
    } else {
      aluno.nota2 = nota;
      updateUser(aluno);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (this.aluno.nota1 != -1 && isNota1) {
      _controller.text = this.aluno.nota1.toString();
    } else if (!isNota1) {
      if (this.aluno.nota2 != -1) {
        _controller.text = this.aluno.nota2.toString();
      }
    }
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
          onChanged: (value) {
            setNota(value);
          },
          controller: _controller,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
