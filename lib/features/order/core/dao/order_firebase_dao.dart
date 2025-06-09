import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:flutter_application_1/features/order/model/order.dart';

class OrderFirestoreDao {
  final fb.FirebaseFirestore _firestore = fb.FirebaseFirestore.instance;
  final String _collection = 'orders';

  Future<List<Order>> getOrders() async {
    final snapshot = await _firestore
        .collection(_collection)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return Order.fromMap(doc.data());
    }).toList();
  }

  Future<void> addOrder(Order order) async {
    await _firestore.collection(_collection).add(order.toMap());
  }
}
