import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'recharge_repository_provider.dart';

final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
  final rechargeRepository = ref.watch(rechargeRepositoryProvider);
  return DataNotifier(rechargesRepository: rechargeRepository);
});

class DataNotifier extends StateNotifier<DataState> {
  final RechargesRepository rechargesRepository;

  DataNotifier({required this.rechargesRepository}) : super(DataState()) {
    Future.microtask(() => getHistory());
  }

  Future getHistory() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final tikects = await rechargesRepository.getHisoty();

    if (tikects.isNotEmpty) {
      state = state.copyWith(isLoading: false, history: tikects);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future buyRecharge(Recharge recharge) async {
    if (state.isBuyLoading) return;

    state = state.copyWith(isBuyLoading: true);

    await rechargesRepository.generateRecharge(
      recharge.cellPhone,
      recharge.value,
      recharge.supplierId,
    );

    await getHistory();

    state = state.copyWith(
      isBuyLoading: false,
    );
  }

}

class DataState {
  final bool isLoading;
  final bool isBuyLoading;
  final List<Ticket> history;

  DataState({
    this.isLoading = false,
    this.history = const [],
    this.isBuyLoading = false,
  });

  DataState copyWith({
    bool? isLoading,
    List<Ticket>? history,
    bool? isBuyLoading,
  }) => DataState(
    isLoading: isLoading ?? this.isLoading,
    history: history ?? this.history,
    isBuyLoading: isBuyLoading ?? this.isBuyLoading,
  );
}
