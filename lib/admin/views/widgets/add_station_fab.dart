import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofence/admin/views/add_station_page.dart';

class AddStationFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (BuildContext context, VoidCallback _) {
        return AddStationPage();
      },
      closedColor: Colors.transparent,
      openElevation: 0.0,
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton.extended(
          onPressed: openContainer,
          icon: const Icon(Icons.add),
          label: const Text('Station'),
        );
      },
    );
  }
}
