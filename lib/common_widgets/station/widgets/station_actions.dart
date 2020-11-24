import 'package:flutter/material.dart';
import 'package:setel_geofence/home/models/station/station.dart';

class StationActions extends StatefulWidget {
  const StationActions({@required this.station});
  final Station station;

  @override
  _StationActionsState createState() => _StationActionsState();
}

class _StationActionsState extends State<StationActions> {
  Future<void> _showDeleteStationDialog(BuildContext context) async {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Station?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("'${widget.station.name}' will be deleted."),
                const Text('Are you sure you want to delete this station?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Delete'),
              color: Theme.of(context).errorColor,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      children: <Widget>[
        const Tooltip(
          message: 'Not available',
          child: OutlineButton(
            onPressed: null,
            child: Text('Edit'),
          ),
        ),
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
            _showDeleteStationDialog(context);
          },
          child: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
      ],
    );
  }
}
