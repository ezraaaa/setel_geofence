import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/admin/views/admin_page.dart';
import 'package:setel_geofence/common_widgets/illustrated_message.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/home/views/widgets/current_location_fab.dart';
import 'package:setel_geofence/home/views/widgets/maps.dart';
import 'package:undraw/undraw.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<StationsBloc>(context).add(LoadStations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeofenceBloc, GeofenceState>(
      listener: (BuildContext context, GeofenceState state) {
        if (state is GeofenceEnterSuccess) {
          print('Entered');
        }
        if (state is GeofenceExitSuccess) {
          print('Exit');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Setel'),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminPage.routeName);
              },
              icon: const Icon(Icons.account_circle_outlined),
              tooltip: 'Admin',
            )
          ],
        ),
        body: BlocBuilder<StationsBloc, StationsState>(
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

                  return Maps(stations: stations);
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
        ),
        floatingActionButton: CurrentLocationFAB(),
      ),
    );
  }
}
