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

  void removeItem(String name, String size, String crust) {
    _cart.removeWhere(
      (item) => item.name == name && item.size == size && item.crust == crust,
    );
  }

  void decreaseQuantityByIndex(int index) {
    if (index >= 0 && index < _cart.length) {
      final item = _cart[index];
      if (item.quantity > 1) {
        _cart[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        _cart.removeAt(index);
      }
    }
  }

  void clearCart() => _cart.clear();

  double calculateTotal() =>
      _cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  int getItemCount() => _cart.fold(0, (sum, item) => sum + item.quantity);
}
