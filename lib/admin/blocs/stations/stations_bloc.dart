import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/repositories/stations/stations_repository.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  StationsBloc({@required StationsRepository stationsRepository})
      : assert(stationsRepository != null),
        _stationsRepository = stationsRepository,
        super(StationsInitial());

  final StationsRepository _stationsRepository;
  StreamSubscription<List<Station>> _stationsStreamSubscription;

  @override
  Stream<StationsState> mapEventToState(
    StationsEvent event,
  ) async* {
    if (event is LoadStations) {
      yield* _mapLoadStationsToState();
    } else if (event is StationsUpdated) {
      yield* _mapStationsUpdatedToState(event.stations);
    }
  }

  Stream<StationsState> _mapLoadStationsToState() async* {
    yield StationsLoadInProgress();
    _stationsStreamSubscription?.cancel();
    _stationsStreamSubscription =
        _stationsRepository.getStations().listen((List<Station> stations) {
      add(StationsUpdated(stations));
    });
  }

  Stream<StationsState> _mapStationsUpdatedToState(
      List<Station> stations) async* {
    yield StationsLoadSuccess(stations);
  }
}
