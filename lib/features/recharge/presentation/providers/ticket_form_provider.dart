import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/presentation/providers/data_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/detail_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/recharge_repository_provider.dart';
import 'package:technical_test/features/shared/shared.dart';

final ticketFormProvider = StateNotifierProvider.autoDispose<TicketFormNotifier, TicketFormState>((ref,) {
  final rechargeRepository = ref.watch(rechargeRepositoryProvider).updateTicketById;
  return TicketFormNotifier(
    rechargeCallback: rechargeRepository, 
    ref: ref
  );
});

class TicketFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Phone phone;
  final Value value;
  final Message message;

  TicketFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.phone = const Phone.pure(),
    this.value = const Value.pure(),
    this.message = const Message.pure(),
  });

  TicketFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Phone? phone,
    Value? value,
    Message? message,
  }) => TicketFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    phone: phone ?? this.phone,
    value: value ?? this.value,
    message: message ?? this.message,
  );
}

class TicketFormNotifier extends StateNotifier<TicketFormState> {
  final Future<Ticket> Function(int, String, double, String) rechargeCallback;
  final Ref ref;

  TicketFormNotifier({required this.rechargeCallback, required this.ref})
    : super(TicketFormState()) {
    _initializeState();
    ref.listen(detailProvider, (_, __) => _initializeState());
  }

  void _initializeState() {
    final ticket = ref.read(detailProvider).ticket;

    if (ticket.id == 0) return;

    state = state.copyWith(
      phone: Phone.dirty(ticket.cellPhone),
      value: Value.dirty(ticket.value.toString()),
      message: Message.dirty(ticket.message),
      isValid: Formz.validate([
        Phone.dirty(ticket.cellPhone),
        Value.dirty(ticket.value.toString()),
        Message.dirty(ticket.message),
      ]),
    );
  }

  void onPhoneChange(String value) {
    final newPhone = Phone.dirty(value);
    state = state.copyWith(
      phone: newPhone,
      isValid: Formz.validate([newPhone, state.value, state.message]),
    );
  }

  void onValueChange(String value) {
    final newValue = Value.dirty(value);
    state = state.copyWith(
      value: newValue,
      isValid: Formz.validate([state.phone, newValue, state.message]),
    );
  }

  void onMessageChange(String value) {
    final newMessage = Message.dirty(value);
    state = state.copyWith(
      message: newMessage,
      isValid: Formz.validate([state.phone, state.value, newMessage]),
    );
  }

  Future<Ticket?> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return null;

    state = state.copyWith(isPosting: true);
    final id = ref.read(detailProvider).ticket.id;

    final result = await rechargeCallback(
      id,
      state.phone.value,
      double.parse(state.value.value.toString()),
      state.message.value,
    );

    ref.read(dataProvider.notifier).getHistory();
    ref.read(detailProvider.notifier).getTicketById(id);

    state = state.copyWith(isPosting: false);
    return result;
  }

  void _touchEveryField() {
    final phone = Phone.dirty(state.phone.value);
    final value = Value.dirty(state.value.value.toString());
    final message = Message.dirty(state.message.value);

    state = state.copyWith(
      isFormPosted: true,
      phone: phone,
      value: value,
      message: message,
      isValid: Formz.validate([phone, value, message]),
    );
  }
}
