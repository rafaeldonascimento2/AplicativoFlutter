import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/core/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class CartScreen extends StatefulWidget {
  final CartController _cartController = CartController();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Pizza>> _futureCartItems;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    _futureCartItems = widget._cartController.cartItems;
  }

  Future<void> _removeFromCart(int index) async {
    await widget._cartController.decreaseItemQuantityByIndex(index);
    _loadCartItems();
    setState(() {});
  }

  Future<void> _finalizeOrder() async {
    await widget._cartController.finalizeOrder();
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
      body: FutureBuilder<List<Pizza>>(
        future: _futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Seu carrinho está vazio 🛒",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final cartItems = snapshot.data!;
          double total = cartItems.fold(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: cartItems.isEmpty ? null : _finalizeOrder,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Fazer Pedido"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
