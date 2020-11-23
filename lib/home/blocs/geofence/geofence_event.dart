part of 'geofence_bloc.dart';

abstract class GeofenceEvent extends Equatable {
  const GeofenceEvent();

  @override
  List<Object> get props => null;
}

class InitiateGeofence extends GeofenceEvent {}

class EnterGeofence extends GeofenceEvent {
  const EnterGeofence(this.id);
  final String id;

  @override
  List<Object> get props => <String>[id];
}

class ExitGeofence extends GeofenceEvent {
  const ExitGeofence(this.id);
  final String id;

  @override
  List<Object> get props => <String>[id];
}
