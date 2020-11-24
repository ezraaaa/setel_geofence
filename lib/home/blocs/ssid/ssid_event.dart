part of 'ssid_bloc.dart';

abstract class SsidEvent extends Equatable {
  const SsidEvent();

  @override
  List<Object> get props => null;
}

class MatchSSID extends SsidEvent {}
