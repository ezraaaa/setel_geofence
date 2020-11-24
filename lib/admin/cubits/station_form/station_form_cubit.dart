import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/admin/models/station_form/latitude.dart';
import 'package:setel_geofence/admin/models/station_form/longitude.dart';
import 'package:setel_geofence/admin/models/station_form/name.dart';
import 'package:setel_geofence/admin/models/station_form/radius.dart';
import 'package:setel_geofence/admin/models/station_form/ssid.dart';
import 'package:setel_geofence/repositories/stations/stations_repository.dart';

part 'station_form_state.dart';

class StationFormCubit extends Cubit<StationFormState> {
  StationFormCubit({@required StationsRepository stationsRepository})
      : assert(stationsRepository != null),
        _stationsRepository = stationsRepository,
        super(const StationFormState());

  final StationsRepository _stationsRepository;

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

  Future<void> addStation() async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final Map<String, dynamic> formData = <String, dynamic>{
      'name': state.name.value,
      'latitude': num.parse(state.latitude.value),
      'longitude': num.parse(state.longitude.value),
      'radius': num.parse(state.radius.value),
      'ssid': state.ssid.value,
    };
    try {
      final DocumentReference docRef =
          await _stationsRepository.addStation(formData);
      final Geolocation geolocation = Geolocation(
        id: docRef.id,
        latitude: double.parse(state.latitude.value),
        longitude: double.parse(state.longitude.value),
        radius: double.parse(state.radius.value),
      );
      Geofence.addGeolocation(geolocation, GeolocationEvent.entry);
    } on PlatformException catch (error) {
      print(error);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } finally {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
