import 'package:formz/formz.dart';

// Define input validation errors
enum MessageError { empty }

// Extend FormzInput and provide the input type and error type.
class Message extends FormzInput<String, MessageError> {

  // Call super.pure to represent an unmodified form input.
  const Message.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Message.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == MessageError.empty ) return 'El campo es requerido';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  MessageError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return MessageError.empty;

    return null;
  }
}