import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'station_form_state.dart';

class StationFormCubit extends Cubit<StationFormState> {
  StationFormCubit() : super(StationFormInitial());
}
