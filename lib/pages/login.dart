import 'package:eldoom/pages/dashboard/dashboard.dart';
import 'package:eldoom/web_api/firebase_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Login é a pagina de abertura do aplicativo. O professor ou aluno irá inserir
//suas credenciais e o aplicativo irá validar num banco de dados;

class Login extends StatefulWidget {

  Future<FirebaseAuth> getFirebaseInstance() async {
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    return FirebaseAuth.instance;
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  final TextEditingController _userControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();
  late Future<FirebaseAuth> firebaseAuth;
  late UserCredential userCredential;

  void rememberUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getBool("remember_me") == true) {
        setState(() {
          isChecked = true;
          _userControl.text = preferences.getString('email')!;
          _passControl.text = preferences.getString('senha')!;
        });

      }
    } catch (e){
      print (e);
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth = widget.getFirebaseInstance();
    rememberUser();
    listUsers();
  }

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
    //listUsers();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Eldoom'),
        ),
      ),
      body: Column(
        children: [
          LoginInput('Email', Icons.person, false, _userControl),
          LoginInput('Senha', Icons.lock, true, _passControl),
          Padding(
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
                      _rememberMe(value!);
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
              onTap: () async {
                if (_userControl.text.isEmpty || _passControl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Preencha os campos.',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  )));
                  return;
                }
                try {
                  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _userControl.text,
                      password: _passControl.text
                  );
                } on FirebaseAuthException {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Dados incorretos.',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      )));
                  return;
                }
                bool excluido = true;
                for (var index = 0; index < users.length; index++) {
                  if (users[index].credential == userCredential.user!.uid.toString()) {
                    excluido = false;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(users[index])));
                    break;
                  }
                }
                if (excluido) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Lamento, sua conta foi excluída por um professor.',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      )));
                  FirebaseAuth.instance.currentUser!.delete();
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

  void _rememberMe(bool value) {
    SharedPreferences.getInstance().then((prefs) => {
      prefs.setBool("remember_me", value),
      prefs.setString("email", _userControl.text),
      prefs.setString("senha", _passControl.text),
    });
    setState(() {
      isChecked = value;
    });
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
