import 'package:formz/formz.dart';

enum LatitudeError { empty }

class Latitude extends FormzInput<String, LatitudeError> {
  // Call super.pure to represent an unmodified form input.
  const Latitude.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Latitude.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LatitudeError validator(String value) {
    return value?.isNotEmpty == true ? null : LatitudeError.empty;
  }
}
