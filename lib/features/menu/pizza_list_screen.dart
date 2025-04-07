import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/menu/pizza_details_screen.dart';

class PizzaListScreen extends StatelessWidget {
  final Function(String, double, int, String, String, String) addToCart;

  PizzaListScreen({super.key, required this.addToCart});

  final List<Map<String, dynamic>> pizzasSalgadas = [
    //listas dos itens
    {
      "name": "Pizza Margherita",
      "price": 35.00,
      "image": "assets/pizza_margherita.png",
      "description": "Molho de tomate, mussarela e manjericão fresco.",
    },
    {
      "name": "Pizza Pepperoni",
      "price": 40.00,
      "image": "assets/pizza_pepperoni.png",
      "description": "Pizza clássica de pepperoni com queijo derretido.",
    },
    {
      "name": "Pizza Quatro Queijos",
      "price": 42.00,
      "image": "assets/pizza_quatro_queijos.png",
      "description": "Mussarela, parmesão, gorgonzola e provolone.",
    },
    {
      "name": "Pizza Frango com Catupiry",
      "price": 38.00,
      "image": "assets/pizza_frango_catupiry.png",
      "description": "Pizza de frango desfiado com catupiry.",
    },
    {
      "name": "Pizza Portuguesa",
      "price": 39.50,
      "image": "assets/pizza_portuguesa.png",
      "description": "Presunto, ovos, cebola e azeitonas.",
    },
    {
      "name": "Pizza Calabresa",
      "price": 36.00,
      "image": "assets/pizza_calabresa.png",
      "description": "Calabresa fatiada com cebola e orégano.",
    },
  ];

  final List<Map<String, dynamic>> pizzasDoces = [
    {
      "name": "Pizza de Chocolate",
      "price": 30.00,
      "image": "assets/pizza_chocolate.png",
      "description": "Chocolate derretido e morangos.",
    },
    {
      "name": "Pizza de Banana com Canela",
      "price": 28.00,
      "image": "assets/pizza_banana.png",
      "description": "Banana caramelizada e canela.",
    },
    {
      "name": "Pizza de Doce de Leite",
      "price": 32.00,
      "image": "assets/pizza_doce_leite.png",
      "description": "Cobertura de doce de leite e coco ralado.",
    },
  ];

  final List<Map<String, dynamic>> bebidas = [
    {
      "name": "Refrigerante Coca-Cola",
      "price": 5.00,
      "image": "assets/coca.png",
      "description": "Lata de 350ml.",
    },
    {
      "name": "Suco de Laranja Natural",
      "price": 7.00,
      "image": "assets/suco_laranja.png",
      "description": "Suco de laranja puro e refrescante.",
    },
    {
      "name": "Água Mineral",
      "price": 3.00,
      "image": "assets/agua.png",
      "description": "Garrafa de 500ml.",
    },
  ];

  final List<Map<String, dynamic>> drinks = [
    {
      "name": "Caipirinha de Limão",
      "price": 15.00,
      "image": "assets/caipirinha.png",
      "description": "Cachaça, limão, açúcar e gelo.",
    },
    {
      "name": "Negroni",
      "price": 18.00,
      "image": "assets/negroni.png",
      "description": "Gin, vermute rosso e Campari.",
    },
    {
      "name": "Piña Colada",
      "price": 20.00,
      "image": "assets/pina_colada.png",
      "description": "Rum, leite de coco e abacaxi.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _buildSection(context, "Pizzas Salgadas", pizzasSalgadas),
        _buildSection(context, "Pizzas Doces", pizzasDoces),
        _buildSection(context, "Bebidas", bebidas),
        _buildSection(context, "Drinks", drinks),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children:
              items.map((item) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading:
                        item["image"] != null
                            ? Image.asset(
                              item["image"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.image_not_supported, size: 50),
                            )
                            : Icon(Icons.image_not_supported, size: 50),
                    title: Text(
                      item["name"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("R\$ ${item["price"].toStringAsFixed(2)}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PizzaDetailsScreen(
                                name: item["name"],
                                basePrice: item["price"],
                                image: item["image"] ?? "",
                                description: item["description"],
                                isPizza: title.contains("Pizza"),
                                addToCart: addToCart,
                              ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
