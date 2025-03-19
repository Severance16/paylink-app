import 'package:dio/dio.dart';
import 'package:technical_test/config/config.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/infrastructure/mappers/supplier_mapper.dart';
import 'package:technical_test/features/recharge/infrastructure/mappers/tikect_mapper.dart';

class RechargeDataSourceImpl extends RechargeDatasource {

  late final Dio dio;
  final String token;

  RechargeDataSourceImpl({
    required this.token
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
      headers: {
        'Authorization': token
      }
    )
  );

  @override
  Future<Ticket> generateRecharge( String phone, double value, String supplier) async {
    final response = await dio.post('/api/buy', data: {
      "cellPhone": phone,
      "value": value,
      "supplierId": supplier
    });
    final responseMapped = TikectMapper.jsonToEntity(response.data);
    return responseMapped;
  }

  @override
  Future<List<Supplier>> getSuppliers() async {
    final response = await dio.get<List>('/api/getSuppliers');
    final List<Supplier> suppliers = [];
    for (final supplier in response.data ?? []) {
      suppliers.add(SupplierMapper.jsonToEntity(supplier));
    }
    return suppliers;
  }
  
  @override
  Future<List<Ticket>> getHisoty() async {
    final response = await dio.get<List>('/transaction');
    final List<Ticket> history = [];
    for (var tikect in response.data ?? []) {
      history.add(TikectMapper.jsonToEntity(tikect));
    }
    return history;
  }
  
  @override
  Future<Ticket> getTicketById(int id) async {
    final response = await dio.get('/transaction/$id');
    return TikectMapper.jsonToEntity(response.data);
  }
  
  @override
  Future<void> deleteTicketById(int id) async {
    await dio.delete('/transaction/$id');
  }
  
}