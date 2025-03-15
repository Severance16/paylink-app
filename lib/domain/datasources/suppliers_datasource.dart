import 'package:technical_test/domain/entities/supplier.dart';

abstract class SuppliersDatasource {
  Future<List<Supplier>> getSuppliers();
}