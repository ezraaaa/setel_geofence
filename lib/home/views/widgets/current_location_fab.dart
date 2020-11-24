import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:setel_geofence/home/blocs/current_location/current_location_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/cubits/map/map_cubit.dart';

class CurrentLocationFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (BuildContext context, PermissionState state) {
        if (state is PermissionRequestSuccess) {
          return BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
            builder:
                (BuildContext context, CurrentLocationState locationState) {
              if (locationState is CurrentLocationLoadSuccess) {
                final Coordinate coordinate = locationState.coordinate;

                return FloatingActionButton(
                  onPressed: () {
                    context
                        .read<CurrentLocationBloc>()
                        .add(LoadCurrentLocation());
                    context.read<MapCubit>().animateToLocation(
                          LatLng(coordinate.latitude, coordinate.longitude),
                        );
                  },
                  child: const Icon(Icons.my_location),
                );
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
