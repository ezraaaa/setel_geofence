part of 'geofences_bloc.dart';

abstract class GeofencesState extends Equatable {
  const GeofencesState();

  @override
  List<Object> get props => null;
}

class GeofencesInitial extends GeofencesState {}

class GeofencesUpdateInProgress extends GeofencesState {}

class GeofencesUpdateSuccess extends GeofencesState {}
