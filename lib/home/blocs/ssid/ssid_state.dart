part of 'ssid_bloc.dart';

abstract class SsidState extends Equatable {
  const SsidState();

  @override
  List<Object> get props => null;
}

class SsidInitial extends SsidState {}

class SSIDMatchInProgress extends SsidState {}

class SSIDMatchSuccess extends SsidState {
  const SSIDMatchSuccess(this.station);
  final Station station;

  @override
  List<Object> get props => <Station>[station];
}
