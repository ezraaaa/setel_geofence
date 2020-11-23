import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/common_widgets/illustrated_message.dart';
import 'package:setel_geofence/common_widgets/loader.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:undraw/illustrations.dart';

class AdminPage extends StatelessWidget {
  static const String routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Admin'),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<StationsBloc, StationsState>(
              builder: (BuildContext context, StationsState state) {
                if (state is StationsLoadSuccess) {
                  final List<Station> stations = state.stations;

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final Station station = stations[index];

                      return ListTile(
                        title: Text(station.name),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: stations.length,
                  );
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
                  subtitle: 'It seems like we are having difficulty in loading',
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Station'),
        onPressed: () {},
      ),
    );
  }
}
