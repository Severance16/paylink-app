import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneError { empty, length, initForThree }

// Extend FormzInput and provide the input type and error type.
class Phone extends FormzInput<String, PhoneError> {

  static final RegExp phoneLengthRegExp = RegExp(
    r'^.{10}$',
  );
  static final RegExp phoneInitRegExp = RegExp(
    r'^3.*$',
  );

  const Phone.pure() : super.pure('');

  const Phone.dirty( super.value ) : super.dirty();



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PhoneError.empty ) return 'El campo es requerido';
    if ( displayError == PhoneError.length ) return 'El numero de telefono debe tener 10 digitos';
    if ( displayError == PhoneError.initForThree ) return 'El numero de telefono debe iniciar por 3';

    return null;
  }

  @override
  PhoneError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return PhoneError.empty;
    if ( !phoneLengthRegExp.hasMatch(value) ) return PhoneError.length;
    if ( !phoneInitRegExp.hasMatch(value) ) return PhoneError.initForThree;

    return null;
  }
}