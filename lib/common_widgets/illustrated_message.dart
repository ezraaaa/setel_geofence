import 'package:flutter/material.dart';
import 'package:setel_geofence/common_widgets/undraw_drawings.dart';
import 'package:undraw/undraw.dart';

class IllustratedMessage extends StatelessWidget {
  const IllustratedMessage({
    @required this.illustration,
    this.width,
    this.height,
    this.title,
    this.subtitle,
  });
  final UnDrawIllustration illustration;
  final double width;
  final double height;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UnDrawDrawings(
          illustration: illustration,
          width: width ?? MediaQuery.of(context).size.width * 1,
          height: height ?? MediaQuery.of(context).size.width * 1,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: AnimatedDefaultTextStyle(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
              duration: const Duration(milliseconds: 200),
              child: ListTile(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
