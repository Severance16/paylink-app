import 'package:technical_test/features/auth/domain/domain.dart';

abstract class AuthDataSource {
  Future<Token> login(String user, String password);
  Future<Token> checkAuthStatus(String token);
}