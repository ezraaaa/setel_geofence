part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => null;
}

class MapInitial extends MapState {}

class MapControllerInitiated extends MapState {
  const MapControllerInitiated(this.googleMapController);
  final GoogleMapController googleMapController;

  @override
  List<Object> get props => <GoogleMapController>[googleMapController];
}
