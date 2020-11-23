import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/blocs/stations/stations_bloc.dart';
import 'package:setel_geofence/admin/views/admin_page.dart';
import 'package:setel_geofence/home/blocs/permission/permission_bloc.dart';
import 'package:setel_geofence/home/views/widgets/maps.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Setel'),
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
      body: Maps(),
      floatingActionButton: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (BuildContext context, PermissionState state) {
          if (state is PermissionRequestSuccess) {
            return FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.my_location),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
