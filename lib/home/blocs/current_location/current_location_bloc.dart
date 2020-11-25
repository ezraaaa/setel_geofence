import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:location/location.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc() : super(CurrentLocationInitial());

  @override
  Stream<CurrentLocationState> mapEventToState(
    CurrentLocationEvent event,
  ) async* {
    if (event is LoadCurrentLocation) {
      yield* _mapLoadCurrentLocationToState();
    }
  }

  Stream<CurrentLocationState> _mapLoadCurrentLocationToState() async* {
    yield CurrentLocationLoadInProgress();
    final Location location = Location();
    final LocationData locationData = await location.getLocation();
    final Coordinate coordinate =
        Coordinate(locationData.latitude, locationData.longitude);
    yield CurrentLocationLoadSuccess(coordinate);
  }
}
