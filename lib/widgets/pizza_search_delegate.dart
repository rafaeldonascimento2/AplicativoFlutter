import 'package:flutter/material.dart'; 
import '../screens/pizza_details_screen.dart';

class PizzaSearchDelegate extends SearchDelegate<String> {
  final Function(String, double, int, String, String) addToCart;

  PizzaSearchDelegate({required this.addToCart});

  final List<Map<String, dynamic>> menu = [
    // Pizzas Salgadas
    {"name": "Pizza Margherita", "price": 35.00, "image": "assets/pizza_margherita.png", "description": "Molho de tomate, mussarela e manjericão fresco.", "category": "Pizzas Salgadas"},
    {"name": "Pizza Pepperoni", "price": 40.00, "image": "assets/pizza_pepperoni.png", "description": "Pizza clássica de pepperoni com queijo derretido.", "category": "Pizzas Salgadas"},
    {"name": "Pizza Quatro Queijos", "price": 42.00, "image": "assets/pizza_quatro_queijos.png", "description": "Mussarela, parmesão, gorgonzola e provolone.", "category": "Pizzas Salgadas"},
    {"name": "Pizza Frango com Catupiry", "price": 38.00, "image": "assets/pizza_frango_catupiry.png", "description": "Pizza de frango desfiado com catupiry.", "category": "Pizzas Salgadas"},
    {"name": "Pizza Portuguesa", "price": 39.50, "image": "assets/pizza_portuguesa.png", "description": "Presunto, ovos, cebola e azeitonas.", "category": "Pizzas Salgadas"},
    {"name": "Pizza Calabresa", "price": 36.00, "image": "assets/pizza_calabresa.png", "description": "Calabresa fatiada com cebola e orégano.", "category": "Pizzas Salgadas"},

    // Pizzas Doces
    {"name": "Pizza de Chocolate", "price": 30.00, "image": "assets/pizza_chocolate.png", "description": "Chocolate derretido e morangos.", "category": "Pizzas Doces"},
    {"name": "Pizza de Banana com Canela", "price": 28.00, "image": "assets/pizza_banana.png", "description": "Banana caramelizada e canela.", "category": "Pizzas Doces"},
    {"name": "Pizza de Doce de Leite", "price": 32.00, "image": "assets/pizza_doce_leite.png", "description": "Cobertura de doce de leite e coco ralado.", "category": "Pizzas Doces"},

    // Bebidas
    {"name": "Refrigerante Lata Coca-Cola", "price": 5.00, "image": "assets/coca.png", "description": "Lata de 350ml.", "category": "Bebidas"},
    {"name": "Suco Natural de Laranja", "price": 7.00, "image": "assets/suco_laranja.png", "description": "Suco de laranja natural.", "category": "Bebidas"},
    {"name": "Água Mineral", "price": 3.00, "image": "assets/agua.png", "description": "Garrafa de 500ml.", "category": "Bebidas"},

    // Drinks
    {"name": "Caipirinha de Limão", "price": 15.00, "image": "assets/caipirinha.png", "description": "Cachaça, limão, açúcar e gelo.", "category": "Drinks"},
    {"name": "Negroni", "price": 18.00, "image": "assets/negroni.png", "description": "Gin, vermute rosso e Campari.", "category": "Drinks"},
    {"name": "Piña Colada", "price": 20.00, "image": "assets/pina_colada.png", "description": "Rum, leite de coco e abacaxi.", "category": "Drinks"},
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final results = menu.where((item) => item["name"].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Image.asset(
            item["image"],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
          ),
          title: Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("R\$ ${item["price"].toStringAsFixed(2)}"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PizzaDetailsScreen(
                  name: item["name"],
                  basePrice: item["price"],
                  image: item["image"],
                  description: item["description"],
                  addToCart: (name, price, quantity, size, crust, observation) {  
                   addToCart(name, price, quantity, size, crust);  
                  },
                  isPizza: item["category"] == "Pizzas Salgadas" || item["category"] == "Pizzas Doces",
                ),
              ),
            );
          },
        );
      },
    );
  }
}
