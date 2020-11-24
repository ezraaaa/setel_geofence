part of 'update_station_bloc.dart';

abstract class UpdateStationState extends Equatable {
  const UpdateStationState();

  @override
  List<Object> get props => null;
}

class UpdateStationInitial extends UpdateStationState {}

class StationRemoveInProgress extends UpdateStationState {}

class StationRemoveSuccess extends UpdateStationState {
  const StationRemoveSuccess(this.station);
  final Station station;

  @override
  List<Object> get props => <Station>[station];
}

class StationRemoveFailure extends UpdateStationState {
  const StationRemoveFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => <String>[errorMessage];
}
