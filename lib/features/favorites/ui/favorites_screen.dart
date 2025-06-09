import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/favorites/core/controller/favorites_controller.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesController? _controller;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _controller = FavoritesController(userId: user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Favoritos"),
          backgroundColor: const Color.fromARGB(185, 232, 123, 90),
        ),
        body: const Center(
          child: Text("Usuário não autenticado."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        backgroundColor: const Color.fromARGB(185, 232, 123, 90),
      ),
      body: ValueListenableBuilder<List<Pizza>>(
        valueListenable: _controller!,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum item favoritado ainda.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final pizza = favorites[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pizza.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("Tamanho: ${pizza.size}"),
                      Text("Borda: ${pizza.crust}"),
                      Text(
                        "Preço: R\$ ${pizza.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () async {
                            await _controller!.removeFromFavorites(pizza);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Removido dos favoritos')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
