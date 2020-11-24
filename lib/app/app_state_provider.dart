import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/geofences/geofences_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/admin/blocs/update_station/update_station_bloc.dart';
import 'package:setel_geofence/admin/cubits/station_form/station_form_cubit.dart';
import 'package:setel_geofence/app/app.dart';
import 'package:setel_geofence/home/blocs/current_location/current_location_bloc.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/blocs/ssid/ssid_bloc.dart';
import 'package:setel_geofence/home/blocs/wifi/wifi_bloc.dart';
import 'package:setel_geofence/home/cubits/map/map_cubit.dart';
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
          BlocProvider<StationsBloc>(
            create: (BuildContext context) {
              return StationsBloc(
                stationsRepository:
                    RepositoryProvider.of<FirebaseStationsRepository>(context),
              );
            },
          ),
          BlocProvider<GeofenceBloc>(
            create: (BuildContext context) {
              return GeofenceBloc(
                stationsBloc: BlocProvider.of<StationsBloc>(context),
              )..add(InitiateGeofence());
            },
          ),
          BlocProvider<WifiBloc>(
            create: (_) => WifiBloc(),
          ),
          BlocProvider<SsidBloc>(
            create: (BuildContext context) {
              return SsidBloc(
                stationsBloc: BlocProvider.of<StationsBloc>(context),
              );
            },
          ),
          BlocProvider<StationFormCubit>(
            create: (BuildContext context) => StationFormCubit(
              stationsRepository:
                  RepositoryProvider.of<FirebaseStationsRepository>(context),
            ),
          ),
          BlocProvider<MapCubit>(
            create: (_) => MapCubit(),
          ),
          BlocProvider<CurrentLocationBloc>(
            create: (_) => CurrentLocationBloc()..add(LoadCurrentLocation()),
          ),
          BlocProvider<GeofencesBloc>(
            create: (_) => GeofencesBloc(),
          ),
          BlocProvider<UpdateStationBloc>(create: (BuildContext context) {
            return UpdateStationBloc(
              stationsRepository:
                  RepositoryProvider.of<FirebaseStationsRepository>(context),
            );
          })
        ],
        child: App(),
      ),
    );
  }
}
