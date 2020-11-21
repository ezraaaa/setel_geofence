import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/app/app.dart';
import 'package:setel_geofence/home/blocs/bloc/permission_bloc.dart';
import 'package:setel_geofence/repositories/permission/permission_repository.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<PermissionRepository>(
          create: (_) => PermissionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<PermissionBloc>(
            create: (BuildContext context) {
              return PermissionBloc(
                permissionRepository:
                    RepositoryProvider.of<PermissionRepository>(context),
              )..add(CheckLocationPermission());
            },
          ),
        ],
        child: App(),
      ),
    );
  }
}
