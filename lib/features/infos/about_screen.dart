import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/menu/home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  // Tela de Sobre o App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o App'),
        backgroundColor: Color.fromARGB(
          185,
          232,
          123,
          90,
        ), // Cor suavizada da AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ), // Redireciona para a tela Home
              );
            }
          },
        ),
      ),
      body: Padding(
        // Espaçamento interno
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pizzaria Flutter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplicativo desenvolvido para facilitar pedidos de pizza.',
            ), // Descrição do App
            SizedBox(height: 20),
            Text(
              'Desenvolvido por: Rafael do Nascimento - 838776',
            ), // Nome do desenvolvedor
          ],
        ),
      ),
    );
  }
}
