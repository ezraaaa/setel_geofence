import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:setel_geofence/common_widgets/station/station_details.dart';
import 'package:setel_geofence/home/models/station/station.dart';

class StationList extends StatefulWidget {
  const StationList({@required this.stations});
  final List<Station> stations;

  @override
  _StationListState createState() => _StationListState();
}

class _StationListState extends State<StationList> {
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
              isAdmin: true,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final Station station = widget.stations[index];

        return ListTile(
          onTap: () {
            _showStationDetailsBottomSheet(context: context, station: station);
          },
          leading: Wrap(
            direction: Axis.vertical,
            spacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const Icon(MdiIcons.mapMarkerRadiusOutline),
              Text(
                '${station.radius} m',
              )
            ],
          ),
          title: Text(station.name),
          subtitle: Text('${station.numberOfPumps} pumps'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: widget.stations.length,
    );
  }
}
