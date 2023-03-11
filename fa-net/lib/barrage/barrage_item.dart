import 'package:flutter/material.dart';
import 'package:flutter_bili_app/barrage/HiSocket.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;

  const BarrageItem(
      {Key key, this.id, this.top, this.onComplete, this.duration, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Container(
        child: child,
      ),
    );
  }
}
