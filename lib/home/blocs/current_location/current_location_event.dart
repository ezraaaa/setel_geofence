part of 'current_location_bloc.dart';

abstract class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();

  @override
  List<Object> get props => null;
}

class LoadCurrentLocation extends CurrentLocationEvent {}

class CurrentLocationUpdated extends CurrentLocationEvent {
  const CurrentLocationUpdated(this.coordinate);
  final Coordinate coordinate;

  @override
  List<Object> get props => <Coordinate>[coordinate];
}
