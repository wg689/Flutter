import 'package:flutter/material.dart';
import 'package:flutter_bili_app/barrage/HiSocket.dart';
import 'package:flutter_bili_app/barrage/barrage_transition.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;

  BarrageItem(
      {Key key,
      this.id,
      this.top,
      this.onComplete,
      this.duration = const Duration(milliseconds: 9000),
      this.child})
      : super(key: key);

  var _key = GlobalKey<BarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
            key: _key,
            child: child,
            onComplete: (v) {
              onComplete(id);
            },
            duration: duration));
  }
}
