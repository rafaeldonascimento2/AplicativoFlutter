import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:
              () =>
                  Navigator.of(context).canPop()
                      ? Navigator.pop(context)
                      : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.local_pizza,
              size: 100,
              color: Colors.deepOrange.withOpacity(0.8),
            ),
            const SizedBox(height: 30),
            const Text(
              'Pizzaria Flutter',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Aplicativo desenvolvido para revolucionar a experiência em pedidos de pizza, '
                'oferecendo praticidade e sabores incríveis!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            _buildDeveloperCard(
              name: 'Rafael do Nascimento',
              matriculation: '838776',
              icon: Icons.code,
            ),
            const SizedBox(height: 20),
            _buildDeveloperCard(
              name: 'Gabriel Terra Simões',
              matriculation: '838446',
              icon: Icons.developer_mode,
            ),
            const SizedBox(height: 40),
            const Text(
              'Versão 1.0.0',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard({
    required String name,
    required String matriculation,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.deepOrange),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Matrícula: $matriculation',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
