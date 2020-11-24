import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.3,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
