import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/repositories/stations/stations_repository.dart';

part 'update_station_event.dart';
part 'update_station_state.dart';

class UpdateStationBloc extends Bloc<UpdateStationEvent, UpdateStationState> {
  UpdateStationBloc({@required StationsRepository stationsRepository})
      : assert(stationsRepository != null),
        _stationsRepository = stationsRepository,
        super(UpdateStationInitial());

  final StationsRepository _stationsRepository;

  @override
  Stream<UpdateStationState> mapEventToState(
    UpdateStationEvent event,
  ) async* {
    if (event is RemoveStation) {
      yield* _mapRemoveStationToState(event.station);
    }
  }

  Stream<UpdateStationState> _mapRemoveStationToState(Station station) async* {
    yield StationRemoveInProgress();
    try {
      await _stationsRepository.removeStation(station.id);
    } on PlatformException catch (error) {
      yield StationRemoveFailure(error.message);
    } finally {
      yield StationRemoveSuccess(station);
    }
  }
}
