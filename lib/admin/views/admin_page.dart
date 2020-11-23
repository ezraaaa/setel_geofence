import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static const String routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Admin'),
          )
        ],
      ),
    );
  }
}
