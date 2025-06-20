import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/order/core/controllers/order_controller.dart';
import 'package:flutter_application_1/features/order/model/order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        backgroundColor: Color.fromARGB(185, 232, 123, 90),
      ),
      body: FutureBuilder<List<Order>>(
        future: orderController.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar pedidos.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Nenhum pedido registrado ainda.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pedido ${index + 1} - ${order.date}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Column(
                        children: order.items.map((item) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "🍕 ${item.name} (${item.size}) - Borda: ${item.crust}",
                              ),
                              Text("Quantidade: ${item.quantity}"),
                              Text("Observação: ${item.observation}"),
                              Text(
                                "Preço unitário: R\$ ${item.price.toStringAsFixed(2)}",
                              ),
                              Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                      Text(
                        "Total: R\$ ${order.total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
