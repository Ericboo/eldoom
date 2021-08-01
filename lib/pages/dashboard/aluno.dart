import 'package:flutter/material.dart';

class DashboardAluno extends StatelessWidget {
  final double nota1 = 8;
  final double nota2 = 10;

  @override
  Widget build(BuildContext context) {
    final double median = (nota1 + nota2) / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Neste período, suas notas foram:",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        //TODO: verificar se existem as notas antes de mostrá-las.
                        padding: EdgeInsets.all(16),
                        child: Text(
                          nota1.toString() + " e " + nota2.toString(),
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      "Neste período, sua média é:",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      median.toString(),
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: 50,
                child: Center(
                    child: Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
