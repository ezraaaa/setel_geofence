import 'package:flutter/material.dart';
import 'package:setel_geofence/home/views/widgets/maps.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setel'),
      ),
      body: Maps(),
    );
  }
}
