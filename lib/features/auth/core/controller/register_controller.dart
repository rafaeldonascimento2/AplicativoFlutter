import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';

class RegisterController {
  final UserRamMemoryDao _userDao = DI.getIt.get<UserRamMemoryDao>();

  Future register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      await _userDao.register(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      rethrow;
    }
  }
}
