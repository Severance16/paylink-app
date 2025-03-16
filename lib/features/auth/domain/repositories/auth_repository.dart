import 'package:technical_test/features/auth/domain/entities/token.dart';

abstract class AuthRepository {
  Future<Token> login(String user, String password);
  Future<Token> checkAuthStatus(String token);
}