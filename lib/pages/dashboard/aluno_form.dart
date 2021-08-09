import 'package:eldoom/models/user.dart';
import 'package:eldoom/widgets/input/aluno_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlunoForm extends StatelessWidget {

  final TextEditingController _nomeControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _senhaControl = TextEditingController();
  final TextEditingController _confirmSenhaControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: Colors.redAccent,
            ),
            child: Icon(Icons.arrow_back, color: Colors.black,),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Center(child: Text('Matricular aluno', style: TextStyle(color: Colors.black),)),
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            children: [
              InfoInput(_nomeControl, 'Nome Completo', Icons.person, false),
              InfoInput(_emailControl, 'Email', Icons.alternate_email, false),
              InfoInput(_senhaControl, 'Senha', Icons.lock, true),
              InfoInput(_confirmSenhaControl, 'Confirme a senha', Icons.lock, true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: InkWell(
                  onTap: () async {
                    if (_nomeControl.text.isEmpty || _emailControl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            'Preencha os campos',
                            style: TextStyle(color: Colors.redAccent, fontSize: 16),
                          )));
                      return;
                    }
                    if (_senhaControl.text != _confirmSenhaControl.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            'Os campos de senha diferem.',
                            style: TextStyle(color: Colors.redAccent, fontSize: 16),
                          )));
                      return;
                    }
                    String credential = '';
                    try {
                      UserCredential newUser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailControl.text,
                          password: _senhaControl.text,
                      );
                      if(newUser.user != null) {
                        credential = newUser.user!.uid;
                      }
                    } on FirebaseException catch (e) {
                      if (e.code == "email-already-in-use") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                              'Este email já está em uso.',
                              style: TextStyle(color: Colors.redAccent, fontSize: 16),
                            )));
                        return;
                      }

                      if (e.code == "invalid-email") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                              'Digite um email válido.',
                              style: TextStyle(color: Colors.redAccent, fontSize: 16),
                            )));
                        return;
                      }

                      if (e.code == "weak-password") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                              'Insira uma senha de ao menos 6 dígitos.',
                              style: TextStyle(color: Colors.redAccent, fontSize: 16),
                            )));
                        return;
                      }
                      return;
                    }
                    final Usuario aluno = new Usuario(
                        _nomeControl.text,
                        credential,
                        -1.0,
                        -1.0,
                        true
                    );

                    Navigator.pop(context, aluno);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 400,
                    height: 40,
                    child: Center(
                        child: Text(
                      'Confirmar',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ), //Button
            ],
          ),
        ),
      ),
    );
  }
}


