import 'package:formz/formz.dart';

enum SSIDError { empty }

class SSID extends FormzInput<String, SSIDError> {
  // Call super.pure to represent an unmodified form input.
  const SSID.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const SSID.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  SSIDError validator(String value) {
    return value?.isNotEmpty == true ? null : SSIDError.empty;
  }
}
