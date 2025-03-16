import 'package:technical_test/features/auth/domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository{

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
    }) : dataSource = dataSource ?? AuthDatasourceImpl();

  @override
  Future<Token> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<Token> login(String user, String password) {
    return dataSource.login(user, password);
  }
}