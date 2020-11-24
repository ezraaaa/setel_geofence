import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:setel_geofence/admin/models/station_form/latitude.dart';
import 'package:setel_geofence/admin/models/station_form/longitude.dart';
import 'package:setel_geofence/admin/models/station_form/name.dart';
import 'package:setel_geofence/admin/models/station_form/radius.dart';
import 'package:setel_geofence/admin/models/station_form/ssid.dart';

part 'station_form_state.dart';

class StationFormCubit extends Cubit<StationFormState> {
  StationFormCubit() : super(const StationFormState());

  void nameChanged(String value) {
    final Name name = Name.dirty(value: value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate(<FormzInput<dynamic, dynamic>>[
        name,
        state.latitude,
        state.longitude,
        state.radius,
        state.ssid,
      ]),
    ));
  }

  void latitudeChanged(String value) {
    final Latitude latitude = Latitude.dirty(value: value);
    emit(state.copyWith(
      latitude: latitude,
      status: Formz.validate(<FormzInput<dynamic, dynamic>>[
        latitude,
        state.name,
        state.longitude,
        state.radius,
        state.ssid,
      ]),
    ));
  }

  void longitudeChanged(String value) {
    final Longitude longitude = Longitude.dirty(value: value);
    emit(state.copyWith(
      longitude: longitude,
      status: Formz.validate(<FormzInput<dynamic, dynamic>>[
        longitude,
        state.name,
        state.latitude,
        state.radius,
        state.ssid,
      ]),
    ));
  }

  void radiusChanged(String value) {
    final Radius radius = Radius.dirty(value: value);
    emit(state.copyWith(
      radius: radius,
      status: Formz.validate(<FormzInput<dynamic, dynamic>>[
        radius,
        state.name,
        state.latitude,
        state.longitude,
        state.ssid,
      ]),
    ));
  }

  void ssidChanged(String value) {
    final SSID ssid = SSID.dirty(value: value);
    emit(state.copyWith(
      ssid: ssid,
      status: Formz.validate(<FormzInput<dynamic, dynamic>>[
        ssid,
        state.name,
        state.latitude,
        state.longitude,
        state.radius,
      ]),
    ));
  }
}
