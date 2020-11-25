import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geofence/geofence.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial());

  @override
  Stream<PermissionState> mapEventToState(
    PermissionEvent event,
  ) async* {
    if (event is RequestLocationPermission) {
      yield* _mapRequestLocationPermissionToState();
    }
  }

  Stream<PermissionState> _mapRequestLocationPermissionToState() async* {
    yield PermissionRequestInProgress();
    try {
      Geofence.requestPermissions();
      yield PermissionRequestSuccess();
    } catch (error) {
      print(error);
      yield PermissionRequestFailure();
    }
  }
}
