import 'package:flutter/material.dart';

abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("HiState:页面销毁, 本次setState不执行: ${toString()}");
    }
  }
}
