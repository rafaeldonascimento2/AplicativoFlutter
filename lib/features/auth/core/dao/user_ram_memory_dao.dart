import 'package:flutter_application_1/features/auth/model/user.dart';

class UserRamMemoryDao {
  final List<User> _users = [];

  UserRamMemoryDao() {
    _addDefaultUser();
  }

  void _addDefaultUser() {
    final defaultUser = User(
      name: 'Usuário Admin',
      email: 'admin@example.com',
      phoneNumber: '+5511123456789',
      password: '123123',
    );

    if (!_users.any((user) => user.email == defaultUser.email)) {
      _users.add(defaultUser);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    if (_users.any((user) => user.email == email)) {
      throw Exception('Email já está cadastrado');
    }

    if (password != confirmPassword) {
      throw Exception('Senha e confirmação não coincidem');
    }

    final newUser = User(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );

    _users.add(newUser);
  }

  Future<User> login({required String email, required String password}) async {
    final user = _users.firstWhere(
      (user) => user.email == email,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    if (user.password != password) {
      throw Exception('Senha incorreta');
    }

    return user;
  }

  Future<void> forgotPassword(String email) async {
    final exists = _users.any((user) => user.email == email);

    if (!exists) {
      throw Exception('Email não cadastrado');
    }

    // Simula o envio de instruções para reset de senha
    // Em uma implementação real, aqui seria enviado um email com link de recuperação
  }
}
