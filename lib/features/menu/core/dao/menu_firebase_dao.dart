import 'package:cloud_firestore/cloud_firestore.dart';

class MenuFirestoreDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPizzasSalgadas() async {
    return _getItemsByCollection('pizzasSalgadas');
  }

  Future<List<Map<String, dynamic>>> getPizzasDoces() async {
    return _getItemsByCollection('pizzasDoces');
  }

  Future<List<Map<String, dynamic>>> getBebidas() async {
    return _getItemsByCollection('bebidas');
  }

  Future<List<Map<String, dynamic>>> getDrinks() async {
    return _getItemsByCollection('drinks');
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final all = await Future.wait([
      getPizzasSalgadas(),
      getPizzasDoces(),
      getBebidas(),
      getDrinks(),
    ]);
    return all.expand((list) => list).toList();
  }

  Future<List<Map<String, dynamic>>> _getItemsByCollection(String collectionName) async {
    final snapshot = await _firestore.collection('menus').doc(collectionName).collection('items').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // opcional: manter o id
      return data;
    }).toList();
  }
}

// criar menus (coleção)
//   └── pizzasSalgadas (documentos)
//   └── pizzasDoces
//   └── bebidas
//   └── drinks
