import 'package:eldoom/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

//Login é a pagina de abertura do aplicativo. O professor ou aluno irá inserir
//suas credenciais e o aplicativo irá validar num banco de dados;

//TODO: implementar uma web api.

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isChecked = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Eldoom'),
        ),
      ),
      body: Column(
        children: [
          LoginInput('Email', Icons.person, false),
          LoginInput('Senha', Icons.lock, true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith((state) => Colors.blue),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text('Lembre-se de mim', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),),
              ],
            ),
          ),//Checkbox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
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
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),//Button
          Text(
            'Eldoom é uma plataforma fictícia gratuita feita para o gerenciamento '
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
