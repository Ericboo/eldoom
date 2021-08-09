import 'package:flutter/material.dart';

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
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          controller: widget._controller,
          keyboardType: widget.isObscure
              ? TextInputType.text
              : TextInputType.emailAddress,
          obscureText: widget.isObscure,
          style: TextStyle(color: Colors.black, fontSize: 20),
          decoration: InputDecoration(
            suffix: null,
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
