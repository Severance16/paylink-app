import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/presentation/providers/data_provider.dart';
import 'recharge_repository_provider.dart';

final detailProvider = StateNotifierProvider<DetailNotifier, DetailState>((
  ref,
) {
  final rechargeRepository = ref.watch(rechargeRepositoryProvider);
  return DetailNotifier(rechargesRepository: rechargeRepository, ref: ref);
});

class DetailNotifier extends StateNotifier<DetailState> {
  final RechargesRepository rechargesRepository;
  final Ref ref; 

  DetailNotifier({required this.rechargesRepository,  required this.ref}) : super(DetailState()) {
    // Future.microtask(() => getHistory());
  }

  Future getTicketById(int id) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final ticket = await rechargesRepository.getTicketById(id);

    state = state.copyWith(isLoading: false, ticket: ticket);
  }

  Future deleteTicketById(int id) async {
    if (state.isDeleting) return;

    state = state.copyWith(isDeleting: true);

    await rechargesRepository.deleteTicketById(id);
    ref.read(dataProvider.notifier).getHistory();

    state = state.copyWith(isDeleting: false);
  }

}

class DetailState {
  final bool isLoading;
  final bool isDeleting;
  final Ticket ticket;

  Ticket get blankTicket => Ticket(
    id: 0,
    value: 0,
    cellPhone: "",
    message: "",
    transactionalId: "",
    supplierId: "",
  );

  DetailState({this.isLoading = false, Ticket? ticket, this.isDeleting = false})
    : ticket =
          ticket ??
          Ticket(
            id: 0,
            value: 0,
            cellPhone: "",
            message: "",
            transactionalId: "",
            supplierId: "",
          );

  DetailState copyWith({bool? isLoading, Ticket? ticket, bool? isDeleting}) => DetailState(
    isLoading: isLoading ?? this.isLoading,
    ticket: ticket ?? this.ticket,
    isDeleting: isDeleting ?? this.isDeleting
  );
}
