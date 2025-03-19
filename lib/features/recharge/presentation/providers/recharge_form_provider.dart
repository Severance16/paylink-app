import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/presentation/providers/data_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/recharge_repository_provider.dart';
import 'package:technical_test/features/shared/shared.dart';

final rechargeFormProvider = StateNotifierProvider.autoDispose<RechargeFormNotifier, RechargeFormState>((ref) {
  final rechargeRepository = ref.watch(rechargeRepositoryProvider).generateRecharge;
  return RechargeFormNotifier(
    rechargeCallback: rechargeRepository,
    ref: ref
  );
});

class RechargeFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Phone phone;
  final Value value;
  final SupplierInput supplier; // Usamos SupplierInput

  RechargeFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.phone = const Phone.pure(),
    this.value = const Value.pure(),
    this.supplier = const SupplierInput.pure(), // Estado inicial puro
  });

  RechargeFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Phone? phone,
    Value? value,
    SupplierInput? supplier,
  }) =>
      RechargeFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        phone: phone ?? this.phone,
        value: value ?? this.value,
        supplier: supplier ?? this.supplier,
      );
}


class RechargeFormNotifier extends StateNotifier<RechargeFormState> {
  final Future<Ticket> Function(String, double, String) rechargeCallback;
  final Ref ref; 
  
  RechargeFormNotifier({required this.rechargeCallback, required this.ref,}) : super(RechargeFormState());

  void onPhoneChange(String value) {
    final newPhone = Phone.dirty(value);
    state = state.copyWith(
      phone: newPhone, 
      isValid: Formz.validate([newPhone, state.value]) // Eliminamos supplier porque no es FormzInput
    );
  }

  void onValueChange(String value) {
    final newValue = Value.dirty(value);
    state = state.copyWith(
      value: newValue, 
      isValid: Formz.validate([newValue, state.phone])
    );
  }

  void onSupplierChange(Supplier supplier) {
  final newSupplier = SupplierInput.dirty(supplier);
  state = state.copyWith(
    supplier: newSupplier,
    isValid: Formz.validate([state.phone, state.value, newSupplier]),
  );
}

  Future<Ticket?> onFormSubmit() async {
  _touchEveryField();

  if (!state.isValid) return null;

  state = state.copyWith(isPosting: true);

  final result = await rechargeCallback(
    state.phone.value,
    double.parse(state.value.value.toString()),
    state.supplier.value!.id,
  );

  final ticket = result;

  ref.read(dataProvider.notifier).getHistory();

  state = state.copyWith(isPosting: false);
  return ticket;
}

  void _touchEveryField() {
    final phone = Phone.dirty(state.phone.value);
    final value = Value.dirty(state.value.value.toString());

    state = state.copyWith(
      isFormPosted: true,
      phone: phone,
      value: value,
      isValid: Formz.validate([phone, value])
    );
  }
}
