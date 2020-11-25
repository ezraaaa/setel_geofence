import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

part 'ssid_event.dart';
part 'ssid_state.dart';

class SsidBloc extends Bloc<SsidEvent, SsidState> {
  SsidBloc({@required this.stationsBloc}) : super(SsidInitial()) {
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
  Stream<SsidState> mapEventToState(
    SsidEvent event,
  ) async* {
    if (event is MatchSSID) {
      yield* _mapMatchSSIDToState();
    }
  }

  Stream<SsidState> _mapMatchSSIDToState() async* {
    yield SSIDMatchInProgress();
    final WifiInfo _wifiInfo = WifiInfo();
    final String ssid = await _wifiInfo.getWifiName();
    if (_stations.any((Station station) => station.ssid == ssid)) {
      final Station station = _stations.firstWhere((Station station) {
        return station.ssid == ssid;
      });
      yield SSIDMatchSuccess(station);
    }
  }

  @override
  Future<void> close() {
    _stationsStreamSubscription.cancel();
    return super.close();
  }
}
