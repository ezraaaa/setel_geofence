part of 'update_station_bloc.dart';

abstract class UpdateStationEvent extends Equatable {
  const UpdateStationEvent();

  @override
  List<Object> get props => [];
}

class RemoveStation extends UpdateStationEvent {
  const RemoveStation(this.station);
  final Station station;

  @override
  List<Object> get props => <Station>[station];
}
