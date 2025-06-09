import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class CartFirestoreDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = "cart";

  Future<List<Pizza>> getCart() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs.map((doc) => Pizza.fromMap(doc.data())).toList();
  }

  Future<void> addItem(
    String name,
    double price,
    int quantity,
    String size,
    String crust,
    String observation,
  ) async {
    final id = Pizza.generateId(name, size, crust, observation);
    final docRef = _firestore.collection(_collection).doc(id);

    final doc = await docRef.get();
    if (doc.exists) {
      final existing = Pizza.fromMap(doc.data()!);
      await docRef.update({
        "quantity": existing.quantity + quantity,
      });
    } else {
      final pizza = Pizza(
        name: name,
        price: price,
        quantity: quantity,
        size: size,
        crust: crust,
        observation: observation.isNotEmpty ? observation : "Sem observação",
      );
      await docRef.set(pizza.toMap());
    }
  }

  Future<void> removeItem(String name, String size, String crust, String observation) async {
    final id = Pizza.generateId(name, size, crust, observation);
    await _firestore.collection(_collection).doc(id).delete();
  }

  Future<void> decreaseQuantityById(String id) async {
    final docRef = _firestore.collection(_collection).doc(id);
    final doc = await docRef.get();

    if (doc.exists) {
      final pizza = Pizza.fromMap(doc.data()!);
      if (pizza.quantity > 1) {
        await docRef.update({"quantity": pizza.quantity - 1});
      } else {
        await docRef.delete();
      }
    }
  }

  Future<void> clearCart() async {
    final snapshot = await _firestore.collection(_collection).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

Future<double> calculateTotal() async {
  final items = await getCart();
  return items.fold<double>(
    0.0,
    (sum, item) => sum + (item.price * item.quantity),
  );
}

  Future<int> getItemCount() async {
    final items = await getCart();
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }
}
