import 'package:flutter_application_1/features/menu/model/pizza.dart';

class CartRamMemoryDao {
  final List<Pizza> _cart = [];

  List<Pizza> get cart => List.unmodifiable(_cart);

  void addItem(
    String name,
    double price,
    int quantity,
    String size,
    String crust,
    String observation,
  ) {
    final existingIndex = _cart.indexWhere(
      (item) => item.name == name && item.size == size && item.crust == crust,
    );

    if (existingIndex != -1) {
      _cart[existingIndex] = _cart[existingIndex].copyWith(
        quantity: _cart[existingIndex].quantity + quantity,
      );
    } else {
      _cart.add(
        Pizza(
          name: name,
          price: price,
          quantity: quantity,
          size: size,
          crust: crust,
          observation: observation.isNotEmpty ? observation : "Sem observação",
        ),
      );
    }
  }

  void clearCart() => _cart.clear();

  double calculateTotal() =>
      _cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  int getItemCount() => _cart.fold(0, (sum, item) => sum + item.quantity);
}
