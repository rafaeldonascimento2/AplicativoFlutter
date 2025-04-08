import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_ram_memory_dao.dart';

class MenuController {
  final MenuRamMemoryDao _menuDao = DI.getIt.get<MenuRamMemoryDao>();

  List<Map<String, dynamic>> getPizzasSalgadas() =>
      _menuDao.getPizzasSalgadas();
  List<Map<String, dynamic>> getPizzasDoces() => _menuDao.getPizzasDoces();
  List<Map<String, dynamic>> getBebidas() => _menuDao.getBebidas();
  List<Map<String, dynamic>> getDrinks() => _menuDao.getDrinks();
  List<Map<String, dynamic>> getAllItems() => _menuDao.getAllItems();
}
