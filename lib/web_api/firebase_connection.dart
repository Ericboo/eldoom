import 'dart:convert';

import 'package:eldoom/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = FirebaseFirestore.instance;

Future<List<dynamic>> getUser() async {
  await Firebase.initializeApp();
  CollectionReference fireUser = databaseReference.collection('users');
  var user = [];
  await fireUser.get().then((value) => {
    for (var i = 0; i < value.docs.length; i++) {
      user.add(novoUser(value.docs[i].data())),
    }
  });
  return user;
}

String saveUser(Usuario aluno) {

  CollectionReference users = databaseReference.collection('users');

  users.doc(aluno.credential).set({
    'nome': aluno.nome,
    'credential': aluno.credential,
    'nota1': -1.0,
    'nota2': -1.0,
    'isAluno': true,
  });
  return aluno.credential;
}

void deleteUser(Usuario aluno) async {

  var user = databaseReference.collection('users').doc(aluno.credential);

  user.delete();

}

void updateUser(Usuario aluno) {


  Map<String, dynamic> map = {
    'nome': aluno.nome,
    'credential': aluno.credential,
    'nota1': aluno.nota1,
    'nota2': aluno.nota2,
    'isAluno': true,
  };

  print(aluno.nota1);

  var user = databaseReference.collection('users').doc(aluno.credential);
  
  user.update(map);
}

void autentication () async {
  await Firebase.initializeApp();
  FirebaseAuth.instance;
}
