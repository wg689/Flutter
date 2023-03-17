import 'dart:ui';

import 'package:flutter/material.dart';

class HiBlur extends StatelessWidget {
  final Widget child;
  final double sigma;

  const HiBlur({Key key, this.sigma = 10, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.white10,
        child: child,
      ),
    );
  }
}
