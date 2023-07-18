import 'package:formz/formz.dart';

// Define input validation errors
enum NamesError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Names extends FormzInput<String, NamesError> {
  // Call super.pure to represent an unmodified form input.
  const Names.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Names.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == NamesError.empty) return 'El campo es requerido';
    if (displayError == NamesError.length) {
      return 'El nombre debe tener mínimo 6 caracteres';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NamesError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NamesError.empty;
    if (value.length < 6) return NamesError.length;

    return null;
  }
}
