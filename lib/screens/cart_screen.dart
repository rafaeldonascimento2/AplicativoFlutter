import 'package:flutter/material.dart';
import '../models/pizza.dart';

class CartScreen extends StatefulWidget {
  final List<Pizza> cartItems;
  final VoidCallback finalizeOrder;

  CartScreen({required this.cartItems, required this.finalizeOrder});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeFromCart(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index] = Pizza(
          name: widget.cartItems[index].name,
          price: widget.cartItems[index].price,
          quantity: widget.cartItems[index].quantity - 1,
          size: widget.cartItems[index].size,
          crust: widget.cartItems[index].crust,
          observation: widget.cartItems[index].observation,
        );
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                "Seu carrinho está vazio 🛒",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text("${item.name} (${item.size})"),
                            subtitle: Text("Quantidade: ${item.quantity}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("R\$ ${(item.price * item.quantity).toStringAsFixed(2)}"),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: widget.cartItems.isEmpty
                        ? null
                        : () {
                            widget.finalizeOrder(); 
                            Navigator.pop(context); 
                          },
                    child: Text("Fazer Pedido"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
