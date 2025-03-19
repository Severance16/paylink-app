import 'package:formz/formz.dart';

// Define input validation errors
enum UserError { empty, length }

// Extend FormzInput and provide the input type and error type.
class User extends FormzInput<String, UserError> {

  static final RegExp userRegExp = RegExp(
    r'^.{4,}$',
  );

  // Call super.pure to represent an unmodified form input.
  const User.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const User.dirty( super.value ) : super.dirty();



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == UserError.empty ) return 'El campo es requerido';
    if ( displayError == UserError.length ) return 'El usuario debe tener por lo menos 4 digitos';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UserError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return UserError.empty;
    if ( !userRegExp.hasMatch(value) ) return UserError.length;

    return null;
  }
}