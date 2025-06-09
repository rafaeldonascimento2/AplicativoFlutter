import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/favorites/core/dao/favorites_firebase_dao.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class FavoritesController extends ValueNotifier<List<Pizza>> {
  final FavoritesFirestoreDao _dao;

  FavoritesController({required String userId})
      : _dao = FavoritesFirestoreDao(userId: userId),
        super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favoritesList = await _dao.getFavorites();
    value = favoritesList;
    notifyListeners();
  }

  Future<void> addToFavorites(Pizza pizza) async {
    await _dao.addFavorite(pizza);
    await _loadFavorites();
  }

  Future<void> removeFromFavorites(Pizza pizza) async {
    await _dao.removeFavorite(pizza);
    await _loadFavorites();
  }

  bool isFavorite(Pizza pizza) {
    return value.contains(pizza);
  }
}
