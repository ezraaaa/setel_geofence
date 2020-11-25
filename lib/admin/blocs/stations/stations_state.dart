part of 'stations_bloc.dart';

abstract class StationsState extends Equatable {
  const StationsState();

  @override
  List<Object> get props => null;
}

class StationsInitial extends StationsState {}

class StationsLoadInProgress extends StationsState {}

class StationsLoadSuccess extends StationsState {
  const StationsLoadSuccess(this.stations);
  final List<Station> stations;

  @override
  List<Object> get props => <List<Station>>[stations];
}

class StationsLoadFailure extends StationsState {
  const StationsLoadFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => <String>[errorMessage];
}
