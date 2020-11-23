part of 'geofence_bloc.dart';

abstract class GeofenceState extends Equatable {
  const GeofenceState();

  @override
  List<Object> get props => null;
}

class GeofenceInitial extends GeofenceState {}

class GeofenceEnterSuccess extends GeofenceState {
  const GeofenceEnterSuccess(this.station);
  final Station station;

  @override
  List<Object> get props => <Station>[station];
}

class GeofenceExitSuccess extends GeofenceState {
  const GeofenceExitSuccess(this.station);
  final Station station;

  @override
  List<Object> get props => <Station>[station];
}
