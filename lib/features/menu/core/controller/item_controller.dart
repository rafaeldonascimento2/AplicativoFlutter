import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_ram_memory_dao.dart';

class ItemController {
  final MenuRamMemoryDao _menuDao = DI.getIt.get<MenuRamMemoryDao>();

  List<Map<String, dynamic>> searchItems(String query) {
    return _menuDao.getAllItems().where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
