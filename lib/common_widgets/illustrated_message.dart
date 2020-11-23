import 'package:flutter/material.dart';
import 'package:setel_geofence/common_widgets/undraw_drawings.dart';
import 'package:undraw/undraw.dart';

class IllustratedMessage extends StatelessWidget {
  const IllustratedMessage({
    @required this.illustration,
    @required this.child,
    this.width,
    this.height,
  });
  final UnDrawIllustration illustration;
  final Widget child;
  final double width;
  final double height;

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
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
