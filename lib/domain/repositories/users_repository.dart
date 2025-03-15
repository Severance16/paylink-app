import 'package:technical_test/domain/entities/user.dart';

abstract class Users {
  Future<String> login(User user);
}