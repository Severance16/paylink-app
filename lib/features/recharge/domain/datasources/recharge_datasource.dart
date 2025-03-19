import 'package:technical_test/features/recharge/domain/entities/entities.dart';

abstract class RechargeDatasource {
  Future<List<Supplier>> getSuppliers();
  Future<Ticket> generateRecharge( String phone, double value, String supplier);
  Future<List<Ticket>> getHisoty();
  Future<Ticket> getTicketById(int id);
  Future<Ticket> updateTicketById(int id, String phone, double value, String message);
  Future<void> deleteTicketById(int id);
}