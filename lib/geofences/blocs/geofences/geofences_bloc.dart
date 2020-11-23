import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/repositories/geofences/geofences_repository.dart';

part 'geofences_event.dart';
part 'geofences_state.dart';

class GeofencesBloc extends Bloc<GeofencesEvent, GeofencesState> {
  GeofencesBloc({@required GeofencesRepository geofencesRepository})
      : assert(geofencesRepository != null),
        _geofencesRepository = geofencesRepository,
        super(GeofencesInitial());

  final GeofencesRepository _geofencesRepository;
  StreamSubscription<List<Station>> _geofencesStreamSubscription;

  @override
  Stream<GeofencesState> mapEventToState(
    GeofencesEvent event,
  ) async* {
    if (event is LoadGeofences) {
      yield* _mapLoadGeofencesToState();
    } else if (event is GeofencesUpdated) {
      yield* _mapGeofencesUpdatedToState(event.stations);
    }
  }

  Stream<GeofencesState> _mapLoadGeofencesToState() async* {
    _geofencesStreamSubscription?.cancel();
    _geofencesStreamSubscription =
        _geofencesRepository.getStations().listen((List<Station> stations) {
      add(GeofencesUpdated(stations));
    });
  }

  Stream<GeofencesState> _mapGeofencesUpdatedToState(
      List<Station> stations) async* {
    yield GeofencesLoadSuccess(stations);
  }
}
