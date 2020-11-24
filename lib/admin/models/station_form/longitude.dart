import 'package:formz/formz.dart';

enum LongitudeError { empty }

class Longitude extends FormzInput<String, LongitudeError> {
  // Call super.pure to represent an unmodified form input.
  const Longitude.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Longitude.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LongitudeError validator(String value) {
    return value?.isNotEmpty == true ? null : LongitudeError.empty;
  }
}
