import 'package:eldoom/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardAluno extends StatelessWidget {
  final Usuario aluno;
  DashboardAluno(this.aluno);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight
              ),
              child: Center(
                child: Container(
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40,),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 32, color: Theme.of(context).primaryColor),
                                    children: [
                                      TextSpan(
                                          text: 'Olá, ',
                                          style: TextStyle(color: Theme.of(context).accentColor)),
                                      TextSpan(
                                        text: aluno.nome,
                                      ),
                                      TextSpan(text: "!")
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                              child: Container(
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: RetornaNota(aluno),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: 400,
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
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class RetornaNota extends StatelessWidget {
  final Usuario aluno;
  late final bool existeMed;

  RetornaNota(this.aluno);

  @override
  Widget build(BuildContext context) {
    final double median = (aluno.nota1 + aluno.nota2) / 2;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Neste período, suas notas foram:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: msgNota(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: existeMed == false ? Container() : Text(
              "Neste período, sua média é:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                existeMed == false
                    ? ''
                    : median.toStringAsPrecision(2),
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 32,),
        ],
      ),
    );
  }

  Widget msgNota() {
    if (aluno.nota1 == -1 && aluno.nota2 == -1) {
      existeMed = false;
      return Text(
        'Suas notas ainda não foram lançadas pelos professores.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.black),
      );
    } else if (aluno.nota1 == -1) {
      existeMed = false;
      return Text(
        'Sua nota 2 é ' +
            aluno.nota2.toString() +
            ' e sua nota 1 ainda não foi lançada.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.black),
      );
    } else if (aluno.nota2 == -1) {
      existeMed = false;
      return Text(
        'Sua nota 1 é ' +
            aluno.nota1.toString() +
            ' e sua nota 2 ainda não foi lançada.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.black),
      );
    } else {
      existeMed = true;
      return Text(
        'Sua nota 1 é ' +
            aluno.nota1.toString() + "."
            '\nSua nota 2 é ' +
            aluno.nota2.toString() +
            '.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.black),
      );
    }
  }

}
