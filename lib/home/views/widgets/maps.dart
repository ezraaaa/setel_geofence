import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:setel_geofence/home/blocs/current_location/current_location_bloc.dart';
import 'package:setel_geofence/home/cubits/map/map_cubit.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/resources/colours.dart';

class Maps extends StatelessWidget {
  const Maps({@required this.stations});
  final List<Station> stations;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
      builder: (BuildContext context, CurrentLocationState state) {
        Coordinate coordinate =
            Coordinate(37.42215078611502, -122.08408970242235);

        if (state is CurrentLocationLoadSuccess) {
          coordinate = state.coordinate;
        }

        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            BlocProvider.of<MapCubit>(context).initMapController(controller);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(coordinate.latitude, coordinate.longitude),
            zoom: 18.0,
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
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        );
      },
    );
  }
}
