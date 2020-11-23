part of 'geofences_bloc.dart';

abstract class GeofencesEvent extends Equatable {
  const GeofencesEvent();

  @override
  List<Object> get props => null;
}

class LoadGeofences extends GeofencesEvent {}

class GeofencesUpdated extends GeofencesEvent {
  const GeofencesUpdated(this.stations);
  final List<Station> stations;

  @override
  List<Object> get props => <List<Station>>[stations];
}
