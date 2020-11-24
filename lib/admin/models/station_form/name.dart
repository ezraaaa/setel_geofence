import 'package:formz/formz.dart';

enum NameError { empty }

class Name extends FormzInput<String, NameError> {
  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameError validator(String value) {
    return value?.isNotEmpty == true ? null : NameError.empty;
  }
}
