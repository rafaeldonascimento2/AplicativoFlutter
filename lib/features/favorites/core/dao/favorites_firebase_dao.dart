import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class FavoritesFirestoreDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  FavoritesFirestoreDao({required this.userId});

  CollectionReference get _favoritesCollection =>
      _firestore.collection('users').doc(userId).collection('favorites');

  Future<List<Pizza>> getFavorites() async {
    final snapshot = await _favoritesCollection.get();
    return snapshot.docs.map((doc) => Pizza.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> addFavorite(Pizza pizza) async {
    final docRef = _favoritesCollection.doc(pizza.id);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set(pizza.toMap());
    }
  }

  Future<void> removeFavorite(Pizza pizza) async {
    await _favoritesCollection.doc(pizza.id).delete();
  }
}
