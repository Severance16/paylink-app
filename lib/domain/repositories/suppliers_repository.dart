import 'package:technical_test/domain/entities/supplier.dart';

abstract class SuppliersRepository {
  Future<List<Supplier>> getSuppliers();
}