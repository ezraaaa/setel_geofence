part of 'geofences_bloc.dart';

abstract class GeofencesEvent extends Equatable {
  const GeofencesEvent();

  @override
  List<Object> get props => null;
}

class UpdateGeofences extends GeofencesEvent {
  const UpdateGeofences(this.stations);
  final List<Station> stations;

  @override
  List<Object> get props => <List<Station>>[stations];
}
