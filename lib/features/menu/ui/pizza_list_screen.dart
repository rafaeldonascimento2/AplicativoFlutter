import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/menu/ui/pizza_details_screen.dart';
import 'package:flutter_application_1/features/menu/core/controller/menu_controller.dart'
    as controller;

class PizzaListScreen extends StatelessWidget {
  final controller.MenuController menuController = controller.MenuController();

  PizzaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _buildSection(
          context,
          "Pizzas Salgadas",
          menuController.getPizzasSalgadas(),
        ),
        _buildSection(context, "Pizzas Doces", menuController.getPizzasDoces()),
        _buildSection(context, "Bebidas", menuController.getBebidas()),
        _buildSection(context, "Drinks", menuController.getDrinks()),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    Future<List<Map<String, dynamic>>> futureItems,
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
        FutureBuilder<List<Map<String, dynamic>>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Erro ao carregar $title'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Nenhum item encontrado em $title'),
              );
            }

            final items = snapshot.data!;
            return Column(
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
                                      (context, error, stackTrace) => Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                      ),
                                )
                                : Icon(Icons.image_not_supported, size: 50),
                        title: Text(
                          item["name"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "R\$ ${(double.tryParse(item["price"].toString()) ?? 0.0).toStringAsFixed(2)}",
                        ),
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
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
            );
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
