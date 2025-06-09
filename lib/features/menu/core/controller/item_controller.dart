import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_firebase_dao.dart';

class ItemController {
  final MenuFirestoreDao _menuDao = DI.getIt.get<MenuFirestoreDao>();

  Future<List<Map<String, dynamic>>> searchItems(String query) async {
    var itens = await _menuDao.getAllItems();  // espera o Future ser resolvido
    return itens.where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
