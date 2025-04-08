import 'package:flutter_application_1/features/order/model/order.dart';

class OrderRamMemoryDao {
  final List<Order> _orders = [];

  List<Order> getOrders() => List.from(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order);
  }
}
