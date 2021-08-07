import 'package:eldoom/models/user.dart';
import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        },),
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
                        return Dismissible(
                          background: Container(alignment: AlignmentDirectional.centerStart,color: Colors.red, child: Icon(Icons.delete_forever),),
                          key: Key(index.toString()),
                          onDismissed: (direction) async {
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                //backgroundColor: Theme.of(context).primaryColor,
                                title: Text('Excluir aluno?'),
                                content: Row(children: [
                                  Text('Deseja excluir '),
                                  Text(alunos[index].nome),
                                  Text('?'),
                                ],),
                                actions: [
                                  Row(
                                    children: [
                                      ExcludeButton(true, aluno: alunos[index]),
                                      SizedBox(width: 10,),
                                      ExcludeButton(false),
                                    ],
                                  ),
                                ],
                              ),
                            );
                            setState(() {
                              updateAlunos();
                            });
                          },
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.all(8),
                            child: Container(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(width: 15,),
                                  Expanded(
                                      child: Text(
                                    alunos[index].nome,
                                    style: TextStyle(fontSize: 20),
                                  )),
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
            saveUser(novoAluno);
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
  final Usuario aluno;

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
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,1}')),
          ],
          onChanged: (value) {
            var temp = double.tryParse(_controller.text);
            if (temp != null && temp > 10) {
              _controller.text = '10.0';
            }
            setNota(value);
          },
          controller: _controller,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}


class ExcludeButton extends StatelessWidget {

  final bool isExcluding;
  final Usuario? aluno;

  ExcludeButton(this.isExcluding, {this.aluno});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (isExcluding) {
            deleteUser(aluno!);
          }
            Navigator.pop(context);
          },
        child: Container(
          child: Center(
              child: Text(
                isExcluding ? 'Excluir' : 'Cancelar',
                style: TextStyle(fontSize: 16),),
          ),
          color: isExcluding ? Colors.red[300] : Colors.blue[300],
          height: 40,
        ),
      ),
    );
  }
}



/*Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: InkWell(
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
),
 */