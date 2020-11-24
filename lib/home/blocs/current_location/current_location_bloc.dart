import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geofence/geofence.dart';

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
    try {
      final Coordinate coordinate = await Geofence.getCurrentLocation();
      yield CurrentLocationLoadSuccess(coordinate);
    } catch (error) {
      yield CurrentLocationLoadFailure(error.toString());
    }
  }
}
