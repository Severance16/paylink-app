import 'package:technical_test/features/recharge/domain/entities/entities.dart';

abstract class RechargesRepository {
  Future<List<Supplier>> getSuppliers();
  Future<Ticket> generateRecharge( String phone, double value, String supplier);
  Future<List<Ticket>> getHisoty();
  Future<Ticket> getTicketById(int id);
  Future<void> deleteTicketById(int id);
}