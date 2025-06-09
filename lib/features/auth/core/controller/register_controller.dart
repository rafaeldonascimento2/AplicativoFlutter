import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_firebase_dao.dart';

class RegisterController {
  final FirebaseUserDao _userDao = DI.getIt.get<FirebaseUserDao>();

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
