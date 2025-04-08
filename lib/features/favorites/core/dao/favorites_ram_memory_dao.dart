import 'package:flutter_application_1/features/menu/model/pizza.dart';

class FavoritesRamMemoryDao {
  final List<Pizza> _favorites = [];

  List<Pizza> get favorites => List.unmodifiable(_favorites);

  void addFavorite(Pizza pizza) {
    if (!_favorites.any((p) => p.id == pizza.id)) {
      _favorites.add(pizza);
    }
  }

  void removeFavorite(Pizza pizza) {
    _favorites.removeWhere((p) => p.id == pizza.id);
  }
}
