import 'package:technical_test/features/auth/domain/domain.dart';

class TokenMapper {
  static tokenJsonToEntity(Map<String, dynamic> json) =>
      Token(token: json['token']);
}
