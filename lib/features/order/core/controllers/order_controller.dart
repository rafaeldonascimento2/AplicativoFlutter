import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/order/core/dao/order_firebase_dao.dart';
import 'package:flutter_application_1/features/order/model/order.dart';

class OrderController {
  late final OrderFirestoreDao _orderDao;

  OrderController() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }
    _orderDao = OrderFirestoreDao(userId: user.uid);
  }

  Future<List<Order>> getOrders() => _orderDao.getOrders();

  Future<void> addOrder(Order order) async {
    await _orderDao.addOrder(order);
  }
}
