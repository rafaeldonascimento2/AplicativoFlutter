import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_firebase_dao.dart';

class MenuController {
  final MenuFirestoreDao _menuDao = DI.getIt.get<MenuFirestoreDao>();

  Future<List<Map<String, dynamic>>> getPizzasSalgadas() => _menuDao.getPizzasSalgadas();
  Future<List<Map<String, dynamic>>> getPizzasDoces() => _menuDao.getPizzasDoces();
  Future<List<Map<String, dynamic>>> getBebidas() => _menuDao.getBebidas();
  Future<List<Map<String, dynamic>>> getDrinks() => _menuDao.getDrinks();
  Future<List<Map<String, dynamic>>> getAllItems() => _menuDao.getAllItems();
}
