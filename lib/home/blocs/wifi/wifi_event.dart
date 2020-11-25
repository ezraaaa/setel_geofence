part of 'wifi_bloc.dart';

abstract class WifiEvent extends Equatable {
  const WifiEvent();

  @override
  List<Object> get props => null;
}

class InitiateConnectivity extends WifiEvent {}

class WifiActivityUpdated extends WifiEvent {
  const WifiActivityUpdated(this.connectivityResult);
  final ConnectivityResult connectivityResult;

  @override
  List<Object> get props => <ConnectivityResult>[connectivityResult];
}
