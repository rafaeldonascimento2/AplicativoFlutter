import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/cart/core/dao/cart_firebase_dao.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';
import 'package:flutter_application_1/features/order/core/controllers/order_controller.dart';
import 'package:flutter_application_1/features/order/model/order.dart';

class CartController {
  late final CartFirestoreDao _cartDao;
  final OrderController _orderController = OrderController();

  CartController() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('Usuário não autenticado');
    }
    _cartDao = CartFirestoreDao(userId: userId);
  }

  Future<List<Pizza>> get cartItems async => await _cartDao.getCart();

  Future<void> addToCart(
    String name,
    double price,
    int quantity,
    String size,
    String crust,
    String observation,
  ) async {
    await _cartDao.addItem(name, price, quantity, size, crust, observation);
  }

  Future<void> decreaseItemQuantityByIndex(int index) async {
    final items = await _cartDao.getCart();
    if (index < 0 || index >= items.length) return;

    final pizza = items[index];
    final id = Pizza.generateId(
      pizza.name,
      pizza.size,
      pizza.crust,
      pizza.observation,
    );
    await _cartDao.decreaseQuantityById(id);
  }

  Future<void> finalizeOrder() async {
    final cart = await _cartDao.getCart();
    if (cart.isNotEmpty) {
      final total = await _cartDao.calculateTotal();
      _orderController.addOrder(
        Order(
          items: List.from(cart),
          total: total,
          date: DateTime.now().toString(),
        ),
      );
      await _cartDao.clearCart();
    }
  }

  Future<int> get itemCount async => await _cartDao.getItemCount();
}
