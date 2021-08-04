import 'package:eldoom/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//TODO: VERIFICAR SE É UM ALUNO OU PROFESSOR NO BANCO DE DADOS
//TODO: SE FOR PROFESSOR TRAZER TODOS OS DADOS DOS ALUNOS E PERMITIR MANIPULAÇÃO
//TODO: SE FOR ALUNO TRAZER APENAS OS DADOS DESSE ALUNO

final databaseReference = FirebaseDatabase.instance.reference();

Future<List<dynamic>> getUser() async {
  DataSnapshot dataSnapshot = await databaseReference.child('user/').once();
  List<dynamic> users = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      var user = novoUser(value);
      user.setId(databaseReference.child('user/' + key));
      users.add(user);
    });
  }
  return users;
}

DatabaseReference saveUser(Usuario aluno) {
  var id = databaseReference.child('user/').push();
  id.set(aluno.toJson());
  return id;
}

void deleteUser(Usuario aluno) {
  var id = aluno.getId();
  id.remove();
}

void updateUser(Usuario aluno) {
  var id = aluno.getId();
  Map<String, dynamic> mapa = {
    "nota1": aluno.nota1,
    "nota2": aluno.nota2,
  };
  id.update(mapa);
}

void autentication () async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
}
