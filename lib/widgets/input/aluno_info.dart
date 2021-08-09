import 'package:flutter/material.dart';

class InfoInput extends StatelessWidget {

  final TextEditingController _controller;
  final String label;
  final IconData icon;
  final bool isObscure;

  InfoInput(this._controller, this.label, this.icon, this.isObscure);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: _controller,
          autocorrect: false,
          textCapitalization:
          label.startsWith('Nome') ? TextCapitalization.words : TextCapitalization.none,
          keyboardType:
          isObscure ? TextInputType.text : TextInputType.emailAddress,
          obscureText: isObscure,
          style: TextStyle(color: Colors.black, fontSize: 20),
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