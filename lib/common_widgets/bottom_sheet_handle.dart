import 'package:flutter/material.dart';

class BottomSheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: const Divider(
            thickness: 4.0,
          ),
        ),
      ),
    );
  }
}
