import 'package:formz/formz.dart';

enum ValueError { empty, amount }

class Value extends FormzInput<String, ValueError> {
  const Value.pure() : super.pure('');

  const Value.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ValueError.empty) return 'Debes colocar un valor';
    if (displayError == ValueError.amount) return 'Valor min: \$1,000 max: \$100,000';

    return null;
  }

  @override
  ValueError? validator(String value) {
    if (value.trim().isEmpty) return ValueError.empty;

    final int? numericValue = int.tryParse(value);
    if (numericValue == null || numericValue < 1000 || numericValue > 100000) {
      return ValueError.amount;
    }

    return null;
  }
}
