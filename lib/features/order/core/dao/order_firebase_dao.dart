import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:flutter_application_1/features/order/model/order.dart';

class OrderFirestoreDao {
  final fb.FirebaseFirestore _firestore = fb.FirebaseFirestore.instance;
  final String userId;

  OrderFirestoreDao({required this.userId});

  fb.CollectionReference get _ordersCollection =>
      _firestore.collection('users').doc(userId).collection('orders');

  Future<List<Order>> getOrders() async {
    final snapshot =
        await _ordersCollection.orderBy('date', descending: true).get();

    return snapshot.docs.map((doc) {
      return Order.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addOrder(Order order) async {
    await _ordersCollection.add(order.toMap());
  }
}
