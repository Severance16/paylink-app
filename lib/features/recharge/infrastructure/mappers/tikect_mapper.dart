import 'package:technical_test/features/recharge/domain/domain.dart';

class TikectMapper {
  static jsonToEntity(Map<String, dynamic> json) => Ticket(
    id: json['id'],
    cellPhone: json['cellPhone'],
    message: json['message'],
    supplierId: json['supplierId'],
    transactionalId: json['transactionalID'],
    value: json['value'],
  );
}
