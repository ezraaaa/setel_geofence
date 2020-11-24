import 'package:formz/formz.dart';

enum RadiusError { empty }

class Radius extends FormzInput<String, RadiusError> {
  // Call super.pure to represent an unmodified form input.
  const Radius.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Radius.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  RadiusError validator(String value) {
    return value?.isNotEmpty == true ? null : RadiusError.empty;
  }
}
