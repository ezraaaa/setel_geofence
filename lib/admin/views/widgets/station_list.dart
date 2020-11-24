import 'package:flutter/material.dart';
import 'package:setel_geofence/home/models/station/station.dart';

class StationList extends StatelessWidget {
  const StationList({@required this.stations});
  final List<Station> stations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final Station station = stations[index];

        return ListTile(
          onTap: () {},
          title: Text(station.name),
          subtitle: Text('${station.latitude}, ${station.longitude}'),
          trailing: Text('${station.radius} m'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: stations.length,
    );
  }
}
