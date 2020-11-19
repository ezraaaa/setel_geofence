import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/app/app_state_provider.dart';
import 'package:setel_geofence/common_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  await Firebase.initializeApp();
  Bloc.observer = CommonBlocObserver();

  runApp(AppStateProvider());
}
