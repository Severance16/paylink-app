import 'package:technical_test/features/recharge/domain/domain.dart';

class RechargeRepositoryImpl extends RechargesRepository{

  final RechargeDatasource dataSource;

  RechargeRepositoryImpl(this.dataSource);

  @override
  Future<Ticket> generateRecharge( String phone, double value, String supplier) {
    return dataSource.generateRecharge(phone, value, supplier);
  }

  @override
  Future<List<Supplier>> getSuppliers() {
    return dataSource.getSuppliers();
  }
  
  @override
  Future<List<Ticket>> getHisoty() {
    return dataSource.getHisoty();
  }
  
  @override
  Future<Ticket> getTicketById(int id) {
    return dataSource.getTicketById(id);
  }
  
  @override
  Future<void> deleteTicketById(int id) {
    return dataSource.deleteTicketById(id);
  }
}