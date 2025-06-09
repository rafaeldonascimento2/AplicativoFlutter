import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/order/core/dao/order_firebase_dao.dart';
import 'package:flutter_application_1/features/order/model/order.dart';

class OrderController {
  final OrderFirestoreDao _orderDao = DI.getIt.get<OrderFirestoreDao>();

  Future<List<Order>> getOrders() => _orderDao.getOrders();

  void addOrder(Order order) {
    _orderDao.addOrder(order);
  }
}
