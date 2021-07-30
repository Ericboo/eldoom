import 'package:flutter/material.dart';

//TODO: IMPLEMENTAR CONTROLLERS

class AlunoForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Matricular aluno'),),
      body: Column(
        children: [
          InfoInput('Nome Completo', Icons.person, false),
          InfoInput('Email', Icons.alternate_email, false),
          InfoInput('Senha', Icons.lock, true),
          InfoInput('Confirme a senha', Icons.lock, true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
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
          ),//Button
        ],
      ),
    );
  }
}

class InfoInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isObscure;

  InfoInput(this.label, this.icon, this.isObscure);

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
