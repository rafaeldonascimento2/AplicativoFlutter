import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';
import 'package:flutter_application_1/features/auth/model/user.dart';

class LoginController {
  final UserRamMemoryDao _userDao = UserRamMemoryDao();

  Future<User> login(String email, String password) async {
    try {
      return await _userDao.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
