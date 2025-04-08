import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';

class ForgotPasswordController {
  final UserRamMemoryDao _userDao = DI.getIt.get<UserRamMemoryDao>();

  Future forgotPassword(String email) async {
    try {
      return await _userDao.forgotPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
