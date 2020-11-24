part of 'wifi_bloc.dart';

abstract class WifiState extends Equatable {
  const WifiState();

  @override
  List<Object> get props => null;
}

class WifiInitial extends WifiState {}

class WifiInitiateInProgress extends WifiState {}

class WifiInitiateSuccess extends WifiState {}

class WifiActivityDetectSuccess extends WifiState {}

class WifiActivityDetectFailure extends WifiState {}
