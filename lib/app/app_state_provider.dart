import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/app/app.dart';
import 'package:setel_geofence/geofences/blocs/geofences/geofences_bloc.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/repositories/geofences/firebase_geofences_repository.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<FirebaseGeofencesRepository>(
          create: (_) => FirebaseGeofencesRepository(),
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
              return GeofenceBloc()..add(InitiateGeofence());
            },
          ),
          BlocProvider<GeofencesBloc>(
            create: (BuildContext context) {
              return GeofencesBloc(
                geofencesRepository:
                    RepositoryProvider.of<FirebaseGeofencesRepository>(context),
              );
            },
          ),
        ],
        child: App(),
      ),
    );
  }
}
