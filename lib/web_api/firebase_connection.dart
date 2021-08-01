import 'package:eldoom/models/aluno.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//TODO: VERIFICAR SE É UM ALUNO OU PROFESSOR NO BANCO DE DADOS
//TODO: SE FOR PROFESSOR TRAZER TODOS OS DADOS DOS ALUNOS E PERMITIR MANIPULAÇÃO
//TODO: SE FOR ALUNO TRAZER APENAS OS DADOS DESSE ALUNO

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference saveAlunos(Aluno aluno) {
  var id = databaseReference.child('alunos/').push();
  id.set(aluno.toJson());
  return id;
}
