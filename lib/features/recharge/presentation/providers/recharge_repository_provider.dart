import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/infrastructure/infrastructure.dart';

final rechargeRepositoryProvider = Provider<RechargesRepository>((ref) {

  final token = ref.watch(authProvider).token?.token ?? '';
  
  final rechargeRepository = RechargeRepositoryImpl(RechargeDataSourceImpl(token: token));
  
  return rechargeRepository;
});