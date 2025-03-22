import 'package:flutter/material.dart';
import 'home_screen.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o App'),
        backgroundColor: Color.fromARGB(185, 232, 123, 90), // Cor suavizada da AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Pizzaria Flutter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Aplicativo desenvolvido para facilitar pedidos de pizza.'),
            SizedBox(height: 20),
            Text('Desenvolvido por: [Seu Nome]'),
          ],
        ),
      ),
    );
  }
}
