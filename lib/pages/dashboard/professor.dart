import 'package:flutter/material.dart';

class DashboardProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua turma'),
      ),
      body: ListView(
        children: [
          Card(
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.all(8),
            child: Container(
              height: 40,
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text('FULANE DA SILVE SOUZE')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}