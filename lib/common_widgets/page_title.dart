import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    @required this.title,
    this.subtitle,
  });

  final Text title;
  final Text subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: subtitle == null
              ? Theme.of(context).textTheme.headline6
              : Theme.of(context).textTheme.subtitle1.copyWith(
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                  ),
          child: title,
        ),
        if (subtitle != null)
          AnimatedDefaultTextStyle(
            style: Theme.of(context).textTheme.caption,
            duration: const Duration(milliseconds: 200),
            child: subtitle,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
