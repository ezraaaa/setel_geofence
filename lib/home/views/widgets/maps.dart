import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/common_widgets/illustrated_message.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/resources/colours.dart';
import 'package:undraw/illustrations.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(2.940289981515822, 101.6735709264816);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (BuildContext context, StationsState stationsState) {
        return BlocBuilder<PermissionBloc, PermissionState>(
          builder: (BuildContext context, PermissionState state) {
            if (state is PermissionRequestInProgress ||
                stationsState is StationsLoadInProgress) {
              return const Loader(
                isShimmer: true,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Card(
                    margin: EdgeInsets.zero,
                  ),
                ),
              );
            }
            if (state is PermissionRequestSuccess &&
                stationsState is StationsLoadSuccess) {
              final List<Station> stations = stationsState.stations;

              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 30.0,
                ),
                circles: stations.map((Station station) {
                  return Circle(
                    circleId: CircleId(station.id),
                    radius: double.parse(station.radius.toString()),
                    center: LatLng(
                      double.parse(station.latitude.toString()),
                      double.parse(station.longitude.toString()),
                    ),
                    fillColor: setelBlue100.withOpacity(0.5),
                    strokeWidth: 0,
                    onTap: () {
                      print('Tapped on ${station.name}');
                    },
                    consumeTapEvents: true,
                  );
                }).toSet(),
                buildingsEnabled: true,
                indoorViewEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                scrollGesturesEnabled: true,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
              );
            }
            return Center(
              child: IllustratedMessage(
                illustration: UnDrawIllustration.accept_request,
                height: MediaQuery.of(context).size.width * 0.3,
                title: 'Permission Denied',
                subtitle: 'We could not get your location permission',
              ),
            );
          },
        );
      },
    );
  }
}
