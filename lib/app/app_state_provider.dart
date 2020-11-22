import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/app/app.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<PermissionBloc>(
          create: (BuildContext context) {
            return PermissionBloc()..add(RequestLocationPermission());
          },
        ),
      ],
      child: App(),
    );
  }
}
