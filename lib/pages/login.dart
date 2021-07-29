import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Eldoom'),),),
      body: Column(
        children: [
          LoginInput('Email', Icons.person, false),
          LoginInput('Senha', Icons.lock, true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Login', style: TextStyle(color: Colors.white),)),
              ),
            ),
          ),
          Text('Eldoom é uma plataforma fictícia gratuita feita para o gerenciamento '
              'coordenado de uma turma.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginInput extends StatelessWidget {

  final String label;
  final IconData icon;
  final bool isObscure;
  LoginInput(this.label, this.icon, this.isObscure);

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
          keyboardType: isObscure ? TextInputType.text: TextInputType.emailAddress,
          obscureText: isObscure,
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(icon, color: Theme.of(context).primaryColor,),
            hintText: label,
          ),
        ),
      ),
    );
  }
}
