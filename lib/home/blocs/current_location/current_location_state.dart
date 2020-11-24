part of 'current_location_bloc.dart';

abstract class CurrentLocationState extends Equatable {
  const CurrentLocationState();

  @override
  List<Object> get props => null;
}

class CurrentLocationInitial extends CurrentLocationState {}

class CurrentLocationLoadInProgress extends CurrentLocationState {}

class CurrentLocationLoadSuccess extends CurrentLocationState {
  const CurrentLocationLoadSuccess(this.coordinate);
  final Coordinate coordinate;

  @override
  List<Object> get props => <Coordinate>[coordinate];
}

class CurrentLocationLoadFailure extends CurrentLocationState {
  const CurrentLocationLoadFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => <String>[errorMessage];
}
