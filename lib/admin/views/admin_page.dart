import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/admin/cubits/station_form/station_form_cubit.dart';
import 'package:setel_geofence/admin/views/widgets/add_station_fab.dart';
import 'package:setel_geofence/admin/views/widgets/station_list.dart';
import 'package:setel_geofence/common_widgets/illustrated_message.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:undraw/illustrations.dart';
import 'package:formz/formz.dart';

class AdminPage extends StatefulWidget {
  static const String routeName = '/admin';

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StationFormCubit, StationFormState>(
      listener: (BuildContext context, StationFormState state) {
        if (state.status.isSubmissionSuccess) {
          _scaffoldKey.currentState
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Station added'),
              ),
            );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              snap: true,
              floating: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  'Admin',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            BlocBuilder<StationsBloc, StationsState>(
              builder: (BuildContext context, StationsState state) {
                if (state is StationsLoadSuccess && state.stations.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: IllustratedMessage(
                        illustration: UnDrawIllustration.empty,
                        height: MediaQuery.of(context).size.width * 0.3,
                        title: 'No stations',
                        subtitle:
                            'It seems like there is no stations added.\nPress + to add a station',
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<StationsBloc, StationsState>(
                builder: (BuildContext context, StationsState state) {
                  if (state is StationsLoadSuccess) {
                    final List<Station> stations = state.stations;

                    if (stations.isNotEmpty) {
                      return StationList(stations: stations);
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else if (state is StationsLoadInProgress) {
                    return Loader(
                      isShimmer: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            tileColor: Theme.of(context).dividerColor,
                          );
                        },
                        itemCount: 6,
                      ),
                    );
                  }
                  return const IllustratedMessage(
                    illustration: UnDrawIllustration.server_down,
                    title: 'Could not load',
                    subtitle:
                        'It seems like we are having difficulty in loading',
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: AddStationFAB(),
      ),
    );
  }
}
