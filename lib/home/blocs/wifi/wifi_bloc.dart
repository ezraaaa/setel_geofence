import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'wifi_event.dart';
part 'wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {
  WifiBloc() : super(WifiInitial());

  StreamSubscription<ConnectivityResult> _connectivityStreamSubscription;

  @override
  Stream<WifiState> mapEventToState(
    WifiEvent event,
  ) async* {
    if (event is InitiateConnectivity) {
      yield* _mapInitiateConnectivityToState();
    } else if (event is WifiActivityUpdated) {
      yield* _mapWifiActivityUpdatedToState(event.connectivityResult);
    }
  }

  Stream<WifiState> _mapInitiateConnectivityToState() async* {
    _connectivityStreamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      add(WifiActivityUpdated(result));
    });
  }

  Stream<WifiState> _mapWifiActivityUpdatedToState(
      ConnectivityResult result) async* {
    if (result == ConnectivityResult.wifi) {
      yield WifiActivityDetectSuccess();
    } else {
      yield WifiActivityDetectFailure();
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}
