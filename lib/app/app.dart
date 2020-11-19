import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setel_geofence/home/views/home_page.dart';
import 'package:setel_geofence/resources/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: 'Setel',
        theme: getThemeData(context),
        home: HomePage(),
      ),
    );
  }
}
