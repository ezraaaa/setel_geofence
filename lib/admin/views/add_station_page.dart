import 'package:flutter/material.dart';

class AddStationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Add station'),
          )
        ],
      ),
    );
  }
}
