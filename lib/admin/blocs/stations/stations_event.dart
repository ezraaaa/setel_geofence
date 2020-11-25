part of 'stations_bloc.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();

  @override
  List<Object> get props => null;
}

class LoadStations extends StationsEvent {}

class StationsUpdated extends StationsEvent {
  const StationsUpdated(this.stations);
  final List<Station> stations;

  @override
  List<Object> get props => <List<Station>>[stations];
}
