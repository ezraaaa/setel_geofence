import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/app/app.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/repositories/stations/firebase_stations_repository.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<FirebaseStationsRepository>(
          create: (_) => FirebaseStationsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<PermissionBloc>(
            create: (_) {
              return PermissionBloc()..add(RequestLocationPermission());
            },
          ),
          BlocProvider<GeofenceBloc>(
            create: (_) {
              return GeofenceBloc(
                stationsBloc: BlocProvider.of<StationsBloc>(context),
              )..add(InitiateGeofence());
            },
          ),
          BlocProvider<StationsBloc>(
            create: (BuildContext context) {
              return StationsBloc(
                stationsRepository:
                    RepositoryProvider.of<FirebaseStationsRepository>(context),
              );
            },
          ),
        ],
        child: App(),
      ),
    );
  }
}
