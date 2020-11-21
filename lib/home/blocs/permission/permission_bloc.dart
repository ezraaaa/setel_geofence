import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:setel_geofence/repositories/permission/permission_repository.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc({@required PermissionRepository permissionRepository})
      : assert(permissionRepository != null),
        _permissionRepository = permissionRepository,
        super(PermissionInitial());

  final PermissionRepository _permissionRepository;

  @override
  Stream<PermissionState> mapEventToState(
    PermissionEvent event,
  ) async* {
    if (event is CheckLocationPermission) {
      yield* _mapCheckLocationPermissionToState();
    } else if (event is RequestLocationPermission) {
      yield* _mapRequestLocationPermissionToState();
    }
  }

  Stream<PermissionState> _mapCheckLocationPermissionToState() async* {
    yield PermissionCheckInProgress();
    PermissionStatus status = PermissionStatus.undetermined;
    status = await _permissionRepository.checkPermission(Permission.location);
    switch (status) {
      case PermissionStatus.granted:
        yield PermissionCheckSuccess();
        break;
      case PermissionStatus.permanentlyDenied:
        yield PermissionCheckFailure();
        break;
      case PermissionStatus.denied:
        add(RequestLocationPermission());
        break;
      case PermissionStatus.restricted:
        yield PermissionCheckFailure();
        break;
      case PermissionStatus.undetermined:
        add(RequestLocationPermission());
        break;
      default:
        yield PermissionCheckFailure();
        break;
    }
  }

  Stream<PermissionState> _mapRequestLocationPermissionToState() async* {
    yield PermissionRequestInProgress();
    try {
      await _permissionRepository.requestPermission(Permission.location);
      add(CheckLocationPermission());
    } catch (error) {
      yield PermissionRequestFailure();
    }
  }
}
