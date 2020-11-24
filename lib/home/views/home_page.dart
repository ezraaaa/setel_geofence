import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:setel_geofence/admin/blocs/geofences/geofences_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/admin/views/admin_page.dart';
import 'package:setel_geofence/common_widgets/illustrated_message.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/common_widgets/station/station_details.dart';
import 'package:setel_geofence/home/blocs/geofence/geofence_bloc.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/blocs/ssid/ssid_bloc.dart';
import 'package:setel_geofence/home/blocs/wifi/wifi_bloc.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/home/views/widgets/current_location_fab.dart';
import 'package:setel_geofence/home/views/widgets/maps.dart';
import 'package:undraw/undraw.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void didChangeDependencies() {
    BlocProvider.of<StationsBloc>(context).listen((StationsState state) {
      if (state is StationsLoadSuccess) {
        // Stopped listening to all geofences
        Geofence.removeAllGeolocations();
        // Start listening to geofences
        context.read<GeofenceBloc>().add(InitiateGeofence());
        // Add updated geofences according to station list
        context.read<GeofencesBloc>().add(UpdateGeofences(state.stations));
      }
    });
    BlocProvider.of<StationsBloc>(context).add(LoadStations());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<GeofenceBloc, GeofenceState>(
          listener: (BuildContext context, GeofenceState geofenceState) {
            final SsidState ssidState =
                BlocProvider.of<SsidBloc>(context).state;

            if (geofenceState is GeofenceEnterSuccess ||
                ssidState is SSIDMatchSuccess) {
              _showStationDetailsBottomSheet(
                  context: context,
                  station: (geofenceState as GeofenceEnterSuccess).station);
            }
            if (geofenceState is GeofenceExitSuccess) {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            }
          },
        ),
        BlocListener<WifiBloc, WifiState>(
          listener: (BuildContext context, WifiState state) {
            if (state is WifiActivityDetectSuccess) {
              BlocProvider.of<SsidBloc>(context).add(MatchSSID());
            }
          },
        ),
      ],
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
