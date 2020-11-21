import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/home/blocs/bloc/permission_bloc.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (BuildContext context, PermissionState state) {
        if (state is PermissionCheckInProgress) {
          return const Loader(
            isShimmer: true,
            child: Card(),
          );
        }
        if (state is PermissionCheckSuccess) {
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationButtonEnabled: true,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            scrollGesturesEnabled: true,
          );
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Permission Denied Permanently'),
              RaisedButton(
                onPressed: () {
                  openAppSettings();
                  context.read<PermissionBloc>().add(CheckLocationPermission());
                },
                child: const Text('Settings'),
              )
            ],
          ),
        );
      },
    );
  }
}
