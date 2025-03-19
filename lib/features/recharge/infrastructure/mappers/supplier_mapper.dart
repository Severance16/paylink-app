import 'package:technical_test/features/recharge/domain/domain.dart';

class SupplierMapper {
  static jsonToEntity(Map<String, dynamic> json) => Supplier(
    id: json['id'], 
    name: json['name']
  );
}