import 'package:formz/formz.dart';
import 'package:technical_test/features/recharge/domain/entities/supplier.dart';

enum SupplierError { empty }

class SupplierInput extends FormzInput<Supplier?, SupplierError> {
  
  const SupplierInput.pure() : super.pure(null);

  const SupplierInput.dirty(Supplier? value) : super.dirty(value);

  @override
  SupplierError? validator(Supplier? value) {
    if (value == null) return SupplierError.empty; // Si no hay proveedor seleccionado, es inválido
    return null; 
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == SupplierError.empty) return 'Debe seleccionar un proveedor';
    return null;
  }
}
