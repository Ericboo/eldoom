import 'package:eldoom/models/user.dart';
import 'package:eldoom/web_api/firebase_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotaForm extends StatelessWidget {
  final bool isNota1;
  final TextEditingController _controller = TextEditingController();
  final Usuario aluno;

  NotaForm(this.isNota1, this.aluno);

  void setNota(String value) {
    double? nota = double.tryParse(_controller.text);
    if (nota == null) {
      nota = -1.0;
    }
    if (isNota1) {
      aluno.nota1 = nota;
      updateUser(aluno);
    } else {
      aluno.nota2 = nota;
      updateUser(aluno);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (this.aluno.nota1 != -1 && isNota1) {
      _controller.text = this.aluno.nota1.toString();
    } else if (!isNota1) {
      if (this.aluno.nota2 != -1) {
        _controller.text = this.aluno.nota2.toString();
      }
    }
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,1}')),
          ],
          onChanged: (value) {
            var temp = double.tryParse(_controller.text);
            if (temp != null && temp > 10) {
              _controller.text = '10.0';
            }
            setNota(value);
          },
          controller: _controller,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}