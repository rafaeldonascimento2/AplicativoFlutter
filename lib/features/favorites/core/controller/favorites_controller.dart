import 'package:flutter/material.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/favorites/core/dao/favorites_ram_memory_dao.dart';
import 'package:flutter_application_1/features/menu/model/pizza.dart';

class FavoritesController extends ValueNotifier<List<Pizza>> {
  FavoritesController() : super([]) {
    _loadFavorites();
  }

  final FavoritesRamMemoryDao _dao = DI.getIt.get<FavoritesRamMemoryDao>();

  void _loadFavorites() {
    value = _dao.favorites;
  }

  void addToFavorites(Pizza pizza) {
    _dao.addFavorite(pizza);
    _loadFavorites();
  }

  void removeFromFavorites(Pizza pizza) {
    _dao.removeFavorite(pizza);
    _loadFavorites();
  }

  bool isFavorite(Pizza pizza) {
    return value.contains(pizza);
  }
}
