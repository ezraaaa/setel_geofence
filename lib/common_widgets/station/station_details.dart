import 'package:flutter/material.dart';
import 'package:setel_geofence/common_widgets/bottom_sheet_handle.dart';
import 'package:setel_geofence/common_widgets/page_title.dart';
import 'package:setel_geofence/common_widgets/section_title.dart';
import 'package:setel_geofence/common_widgets/station/widgets/coordinates_section.dart';
import 'package:setel_geofence/common_widgets/station/widgets/station_actions.dart';
import 'package:setel_geofence/home/models/station/station.dart';

class StationDetails extends StatelessWidget {
  const StationDetails(
      {@required this.station, this.isAdmin, @required this.scrollController});
  final Station station;
  final ScrollController scrollController;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: <Widget>[
        BottomSheetHandle(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PageTitle(
                title: Text(station.name),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (isAdmin)
                StationActions(station: station)
              else
                const SizedBox.shrink(),
              const SizedBox(
                height: 32.0,
              ),
              const SectionTitle(text: 'Pumps'),
              const SizedBox(
                height: 16.0,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: <Widget>[
                        GridTile(
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            child: Center(
                              child: Text('${index + 1}'),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: isAdmin
                                ? null
                                : () {
                                    print('Pump ${index + 1}');
                                  },
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: int.parse(station.numberOfPumps.toString()),
              ),
              const SizedBox(
                height: 32.0,
              ),
              const SectionTitle(text: 'WiFi'),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('WiFi Name'),
                subtitle: Text(station.ssid),
                trailing: const IconButton(
                  onPressed: null,
                  tooltip: 'Not available',
                  icon: Icon(Icons.wifi_outlined),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              if (isAdmin)
                CoordinatesSection(
                  station: station,
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
