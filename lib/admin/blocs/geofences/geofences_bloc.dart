import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:setel_geofence/home/models/station/station.dart';

part 'geofences_event.dart';
part 'geofences_state.dart';

class GeofencesBloc extends Bloc<GeofencesEvent, GeofencesState> {
  GeofencesBloc() : super(GeofencesInitial());

  @override
  Stream<GeofencesState> mapEventToState(
    GeofencesEvent event,
  ) async* {
    if (event is UpdateGeofences) {
      yield* _mapUpdateGeofencesToState(event.stations);
    }
  }

  Stream<GeofencesState> _mapUpdateGeofencesToState(
      List<Station> stations) async* {
    yield GeofencesUpdateInProgress();
    Geofence.removeAllGeolocations();
    stations.map((Station station) {
      final Geolocation geolocation = Geolocation(
        id: station.id,
        latitude: double.parse(station.latitude.toString()),
        longitude: double.parse(station.longitude.toString()),
        radius: double.parse(station.radius.toString()),
      );
      Geofence.addGeolocation(geolocation, GeolocationEvent.entry);
    });
    yield GeofencesUpdateSuccess();
  }
}
