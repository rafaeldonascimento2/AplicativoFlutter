import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/features/auth/core/dao/user_firebase_dao.dart';
import 'package:flutter_application_1/features/auth/model/user.dart';

class LoginController {
  final FirebaseUserDao _userDao = DI.getIt.get<FirebaseUserDao>();

  Future<User> login(String email, String password) async {
    try {
      return await _userDao.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
