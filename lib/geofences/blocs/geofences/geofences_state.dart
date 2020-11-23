part of 'geofences_bloc.dart';

abstract class GeofencesState extends Equatable {
  const GeofencesState();

  @override
  List<Object> get props => null;
}

class GeofencesInitial extends GeofencesState {}

class GeofencesLoadInProgress extends GeofencesState {}

class GeofencesLoadSuccess extends GeofencesState {
  const GeofencesLoadSuccess(this.stations);
  final List<Station> stations;

  @override
  List<Object> get props => <List<Station>>[stations];
}

class GeofencesLoadFailure extends GeofencesState {
  const GeofencesLoadFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => <String>[errorMessage];
}
