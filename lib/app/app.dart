import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setel_geofence/admin/views/admin_page.dart';
import 'package:setel_geofence/home/views/home_page.dart';
import 'package:setel_geofence/resources/theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
        routes: <String, Widget Function(BuildContext)>{
          AdminPage.routeName: (BuildContext context) => AdminPage(),
        },
      ),
    );
  }
}
