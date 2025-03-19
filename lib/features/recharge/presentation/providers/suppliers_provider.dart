import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'recharge_repository_provider.dart';

final suppliersProvider = StateNotifierProvider<SuppliersNotifier, SuppliersState>((ref) {
  final rechargeRepository = ref.watch( rechargeRepositoryProvider );
  return SuppliersNotifier(rechargesRepository: rechargeRepository);
},);

class SuppliersNotifier extends StateNotifier<SuppliersState> {

  final RechargesRepository rechargesRepository;
  
  SuppliersNotifier({ required this.rechargesRepository}): super(SuppliersState()){
    getSupliers();
  }

  Future getSupliers() async {

    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final suppliers = await rechargesRepository.getSuppliers();
    
    if (suppliers.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        suppliers: suppliers
      );
    }
  }
}

class SuppliersState {
  final bool isLoading;
  final List<Supplier> suppliers;

  SuppliersState({this.isLoading = false, this.suppliers = const []});

  SuppliersState copyWith({bool? isLoading, List<Supplier>? suppliers}) =>
      SuppliersState(
        isLoading: isLoading ?? this.isLoading,
        suppliers: suppliers ?? this.suppliers
      );
}
