import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setel_geofence/common_widgets/section_title.dart';
import 'package:setel_geofence/home/models/station/station.dart';

class CoordinatesSection extends StatelessWidget {
  const CoordinatesSection({@required this.station});
  final Station station;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SectionTitle(text: 'Coordinates'),
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copy to clipboard',
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                      text: '${station.latitude}, ${station.longitude}'),
                );
              },
            )
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Latitude'),
          subtitle: Text('${station.latitude}'),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Longitude'),
          subtitle: Text('${station.longitude}'),
        ),
      ],
    );
  }
}
