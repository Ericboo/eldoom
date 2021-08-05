import 'package:eldoom/models/user.dart';
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
        title: Text('Matricular aluno'),
      ),
      body: Column(
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
                  return;
                }
                if (_senhaControl.text != _confirmSenhaControl.text) {
                  return;
                }
                UserCredential credential;
                try {
                  credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: _emailControl.text,
                      password: _senhaControl.text
                  );
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
                    credential.user!.uid.toString(),
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
                width: double.infinity,
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
    );
  }
}

class InfoInput extends StatelessWidget {

  final TextEditingController _controller;
  final String label;
  final IconData icon;
  final bool isObscure;

  InfoInput(this._controller, this.label, this.icon, this.isObscure);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: _controller,
          keyboardType:
              isObscure ? TextInputType.text : TextInputType.emailAddress,
          obscureText: isObscure,
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            hintText: label,
          ),
        ),
      ),
    );
  }
}
