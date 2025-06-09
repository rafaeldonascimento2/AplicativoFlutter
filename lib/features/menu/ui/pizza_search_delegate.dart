import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/menu/core/controller/item_controller.dart';
import 'pizza_details_screen.dart';

class PizzaSearchDelegate extends SearchDelegate<String> {
  final ItemController itemController = ItemController();

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
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: itemController.searchItems(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar itens'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum item encontrado'));
        } else {
          final results = snapshot.data!;
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
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.image_not_supported),
                ),
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
                            image: item["image"],
                            description: item["description"],
                            isPizza: item["category"].contains("Pizza"),
                          ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
