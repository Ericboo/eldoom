import 'package:eldoom/models/user.dart';
import 'dart:async';
import 'package:eldoom/pages/dashboard/aluno_form.dart';
import 'package:eldoom/widgets/input/nota.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Center(child: Text("Sua turma", style: TextStyle(fontFamily: 'Cream', color: Colors.black),)),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Container(
                height: 35,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  //color: Colors.redAccent,
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.black,),
                    Text('Sair', style: TextStyle(color: Colors.black, fontSize: 24),),
                  ],
                ),
              ),
            ),
            Expanded(child: InkWell(
              onTap: () async {
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
              child: Container(
                height: 35,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  //color: Colors.greenAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Adicionar aluno', style: TextStyle(color: Colors.black, fontSize: 20),),
                    Icon(Icons.arrow_forward, color: Colors.black,),
                  ],
                ),
              ),
            ),)
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));

                case ConnectionState.done:
                  alunos = snapshot.data as List<dynamic>;
                  return RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(Duration(milliseconds: 200), () {
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
                          background: Row(
                            children: [
                              Expanded(child: Container(alignment: AlignmentDirectional.centerStart,color: Colors.red, child: Icon(Icons.delete_forever),)),
                              Container(alignment: AlignmentDirectional.centerEnd,color: Colors.red, child: Icon(Icons.delete_forever),),
                            ],
                          ),
                          key: Key(index.toString()),
                          onDismissed: (direction) async {
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                //backgroundColor: Theme.of(context).primaryColor,
                                title: Text('Excluir aluno?'),
                                content: Text('Deseja excluir ' + alunos[index].nome + "?"),
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
                            child: Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.view_headline, color: Colors.grey,),
                                  SizedBox(width: 8,),
                                  Expanded(
                                      child: Text(
                                    alunos[index].nome,
                                    style: TextStyle(fontSize: 20,),
                                  )),
                                  NotaForm(true, alunos[index]),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  NotaForm(false, alunos[index]),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  ShowMedian(alunos[index]),
                                  SizedBox(
                                    width: 12,
                                  ),
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
    );
  }
}

class ShowMedian extends StatefulWidget {
  final Usuario aluno;

  ShowMedian(this.aluno);

  @override
  _ShowMedianState createState() => _ShowMedianState();
}

class _ShowMedianState extends State<ShowMedian> {

  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) { });

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.aluno.nota1 != -1 && widget.aluno.nota2 != -1) {
      var median = (widget.aluno.nota1  + widget.aluno.nota2) / 2;
      return Text(median.toStringAsPrecision(2));
    }
    return Text(" -.- ");
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