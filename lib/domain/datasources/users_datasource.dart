import 'package:technical_test/domain/entities/user.dart';

abstract class UsersDatasource {
  Future<String> login(User user);
}