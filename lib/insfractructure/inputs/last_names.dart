import 'package:formz/formz.dart';

// Define input validation errors
enum LastNamesError { empty, length }

// Extend FormzInput and provide the input type and error type.
class LastNames extends FormzInput<String, LastNamesError> {
  // Call super.pure to represent an unmodified form input.
  const LastNames.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const LastNames.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == LastNamesError.empty) return 'El campo es requerido';
    if (displayError == LastNamesError.length) {
      return 'El apellidos debe tener mínimo 6 caracteres';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  LastNamesError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return LastNamesError.empty;
    if (value.length < 6) return LastNamesError.length;

    return null;
  }
}
