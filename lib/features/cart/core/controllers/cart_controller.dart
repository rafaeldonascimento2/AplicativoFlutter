import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/cart/core/dao/cart_ram_memory_dao.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';
import 'package:flutter_application_1/features/order/core/controllers/order_controller.dart';
import 'package:flutter_application_1/features/order/model/order.dart';

class CartController {
  final CartRamMemoryDao _cartDao = DI.getIt.get<CartRamMemoryDao>();
  final OrderController _orderController = OrderController();

  List<Pizza> get cartItems => _cartDao.cart;

  void addToCart(
    String name,
    double price,
    int quantity,
    String size,
    String crust,
    String observation,
  ) {
    _cartDao.addItem(name, price, quantity, size, crust, observation);
  }

  void finalizeOrder() {
    if (_cartDao.cart.isNotEmpty) {
      _orderController.addOrder(
        Order(
          items: List.from(_cartDao.cart),
          total: _cartDao.calculateTotal(),
          date: DateTime.now().toString(),
        ),
      );
      _cartDao.clearCart();
    }
  }

  int get itemCount => _cartDao.getItemCount();
}
