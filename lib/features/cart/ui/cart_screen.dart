import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/core/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class CartScreen extends StatefulWidget {
  final CartController _cartController = CartController();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeFromCart(int index) {
    widget._cartController.decreaseItemQuantityByIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double total = widget._cartController.cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
      body:
          widget._cartController.cartItems.isEmpty
              ? Center(
                child: Text(
                  "Seu carrinho está vazio 🛒",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget._cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = widget._cartController.cartItems[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text("${item.name} (${item.size})"),
                              subtitle: Text("Quantidade: ${item.quantity}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "R\$ ${(item.price * item.quantity).toStringAsFixed(2)}",
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeFromCart(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Total: R\$ ${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          widget._cartController.cartItems.isEmpty
                              ? null
                              : () {
                                widget._cartController.finalizeOrder();
                                Navigator.pop(context);
                              },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("Fazer Pedido"),
                    ),
                  ],
                ),
              ),
    );
  }
}
