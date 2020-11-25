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
    _stationsStreamSubscription = stationsBloc.listen((StationsState state) {
      if (state is StationsLoadSuccess) {
        _stations = state.stations;
      }
    });
  }

  final StationsBloc stationsBloc;
  StreamSubscription<StationsState> _stationsStreamSubscription;
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
    yield GeofenceInitiateInProgress();
    Geofence.initialize();
    Geofence.startListening(GeolocationEvent.entry, (Geolocation entry) {
      add(EnterGeofence(entry.id));
    });

    /// Geofence exit works with only iOS
    /// Existing issue: (https://github.com/DwayneCoussement/flutter_geofence/issues/5)
    Geofence.startListening(GeolocationEvent.exit, (Geolocation entry) {
      add(ExitGeofence(entry.id));
    });
    yield GeofenceInitiated();
  }

  Stream<GeofenceState> _mapEnterGeofence(String id) async* {
    final Station station = _stations.firstWhere((Station station) {
      return station.id == id;
    });
    yield GeofenceEnterSuccess(station);
  }

  Stream<GeofenceState> _mapExitGeofence(String id) async* {
    final Station station = _stations.firstWhere((Station station) {
      return station.id == id;
    });
    yield GeofenceExitSuccess(station);
  }

  @override
  Future<void> close() {
    _stationsStreamSubscription.cancel();
    return super.close();
  }
}
