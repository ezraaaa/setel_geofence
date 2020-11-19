import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial());

  @override
  Stream<PermissionState> mapEventToState(
    PermissionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
