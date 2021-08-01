import 'package:eldoom/models/aluno.dart';
import 'package:eldoom/web_api/firebase_connection.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: InkWell(
              onTap: () {
                if (_nomeControl.text.isEmpty || _emailControl.text.isEmpty) {
                  return;
                }
                if (_senhaControl.text != _confirmSenhaControl.text) {
                  return;
                }
                final Aluno aluno = new Aluno(
                    _nomeControl.text, _emailControl.text, _senhaControl.text);
                aluno.setId(saveAlunos(aluno));
                Navigator.pop(context, aluno);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: 50,
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
      padding: EdgeInsets.all(20),
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
