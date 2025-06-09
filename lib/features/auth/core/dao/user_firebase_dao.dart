import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_application_1/features/auth/model/user.dart';

class FirebaseUserDao {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      throw Exception('Senha e confirmação não coincidem');
    }

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fb.User fbUser = credential.user!;

      await fbUser.updateDisplayName(name);

      await _firestore.collection('users').doc(fbUser.uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e));
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User fbUser = credential.user!;

      return User(
        name: fbUser.displayName ?? '',
        email: fbUser.email ?? '',
        phoneNumber: fbUser.phoneNumber ?? '',
        password: '', 
      );
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e));
    }
  }

  String _getFirebaseErrorMessage(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email já está cadastrado';
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'invalid-email':
        return 'Email inválido';
      case 'weak-password':
        return 'Senha fraca';
      default:
        return 'Erro: ${e.message}';
    }
  }
}
