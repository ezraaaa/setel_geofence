import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/home/models/station/station.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  GeofenceBloc({@required this.stationsBloc}) : super(GeofenceInitial()) {
    final StationsState stationsState = stationsBloc.state;
    if (stationsState is StationsLoadSuccess) {
      _stations = stationsState.stations;
    }
  }

  final StationsBloc stationsBloc;
  List<Station> _stations;

  @override
  Stream<GeofenceState> mapEventToState(
    GeofenceEvent event,
  ) async* {
    if (event is InitiateGeofence) {
      yield* _mapInitiateGeofenceToState();
    } else if (event is EnterGeofence) {
      yield* _mapEnterGeofence(event.id);
    } else if (event is ExitGeofence) {
      yield* _mapExitGeofence(event.id);
    }
  }

  Stream<GeofenceState> _mapInitiateGeofenceToState() async* {
    Geofence.initialize();
    Geofence.startListening(GeolocationEvent.entry, (Geolocation entry) {
      print('Entry of a georegion, Welcome to: ${entry.id}');
      add(EnterGeofence(entry.id));
    });

    Geofence.startListening(GeolocationEvent.exit, (Geolocation entry) {
      print('Exit of a georegion, Byebye to: ${entry.id}');
      add(ExitGeofence(entry.id));
    });
  }

  Stream<GeofenceState> _mapEnterGeofence(String id) async* {
    _stations.firstWhere((Station station) {
      return station.id == id;
    });
  }

  Stream<GeofenceState> _mapExitGeofence(String id) async* {
    _stations.firstWhere((Station station) {
      return station.id == id;
    });
  }
}
