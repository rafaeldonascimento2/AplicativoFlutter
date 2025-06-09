import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_firebase_dao.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';

class ForgotPasswordController {
  final FirebaseUserDao _userDao = DI.getIt.get<FirebaseUserDao>();

  Future forgotPassword(String email) async {
    try {
      return await _userDao.forgotPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
