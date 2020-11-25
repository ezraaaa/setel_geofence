import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:setel_geofence/common_widgets/station/station_details.dart';
import 'package:setel_geofence/home/blocs/current_location/current_location_bloc.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/ssid/ssid_bloc.dart';
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
  Coordinate coordinate = Coordinate(37.42215078611502, -122.08408970242235);

  void _showStationDetailsBottomSheet(
      {@required BuildContext context, @required Station station}) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          expand: false,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return StationDetails(
              station: station,
              scrollController: scrollController,
              isAdmin: false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (BuildContext context, CurrentLocationState state) {
        if (state is CurrentLocationLoadSuccess) {
          setState(() {
            coordinate = state.coordinate;
          });
        }
      },
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          BlocProvider.of<MapCubit>(context).initMapController(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(coordinate.latitude, coordinate.longitude),
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
              final GeofenceState geofenceState =
                  context.read<GeofenceBloc>().state;
              final SsidState ssidState = context.read<SsidBloc>().state;

              if (ssidState is SSIDMatchSuccess ||
                  geofenceState is GeofenceEnterSuccess) {
                final Station _station =
                    (ssidState as SSIDMatchSuccess).station ??
                        (geofenceState as GeofenceEnterSuccess).station;

                if (station.id == _station.id) {
                  _showStationDetailsBottomSheet(
                    context: context,
                    station: station,
                  );
                }
              }
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
      ),
    );
  }
}
