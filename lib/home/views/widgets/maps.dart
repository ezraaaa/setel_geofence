import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:setel_geofence/home/cubits/map/map_cubit.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/resources/colours.dart';

class Maps extends StatefulWidget {
  const Maps({@required this.stations});
  final List<Station> stations;

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final LatLng _center = const LatLng(2.940289981515822, 101.6735709264816);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        BlocProvider.of<MapCubit>(context).initMapController(controller);
      },
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 18.0,
      ),
      circles: widget.stations.map((Station station) {
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
  }
}
