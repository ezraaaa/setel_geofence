part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => null;
}

class CheckLocationPermission extends PermissionEvent {}

class RequestLocationPermission extends PermissionEvent {}
