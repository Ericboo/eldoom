import 'package:eldoom/pages/dashboard/dashboard.dart';
import 'package:eldoom/web_api/firebase_connection.dart';
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
  final TextEditingController _userControl = TextEditingController();
  final TextEditingController _senhaControl = TextEditingController();

  List<dynamic> users = [];

  void listUsers() {
    getUser().then((value) => {
          this.setState(() {
            this.users = value;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    listUsers();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Eldoom'),
        ),
      ),
      body: Column(
        children: [
          LoginInput('Email', Icons.person, false, _userControl),
          LoginInput('Senha', Icons.lock, true, _senhaControl),
          Padding(
            //Lembre-se de mim checkbox//TODO: DESCOBRIR COMO FAZER ISSO FUNCIONAR.
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor:
                      MaterialStateProperty.resolveWith((state) => Colors.blue),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(
                  'Lembre-se de mim',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            //Botão de login
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: InkWell(
              onTap: () {
                if (_userControl.text.isEmpty || _senhaControl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Preencha os campos.',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  )));
                  return;
                }
                bool data = false;
                for (var index = 0; index < users.length; index++) {
                  if (users[index].email == _userControl.text &&
                      users[index].senha == _senhaControl.text) {
                    data = true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard(users[index])));
                  }
                }
                if (!data) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Dados incorretos.',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  )));
                }
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
                  ),
                ),
              ),
            ),
          ),
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

class LoginInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isObscure;
  final TextEditingController _controller;

  LoginInput(this.label, this.icon, this.isObscure, this._controller);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: widget._controller,
          keyboardType: widget.isObscure
              ? TextInputType.text
              : TextInputType.emailAddress,
          obscureText: widget.isObscure,
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              widget.icon,
              color: Theme.of(context).primaryColor,
            ),
            hintText: widget.label,
          ),
        ),
      ),
    );
  }
}
