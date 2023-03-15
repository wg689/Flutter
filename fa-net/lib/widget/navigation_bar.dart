import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_bili_app/provider/theme_provider.dart';
import 'package:provider/src/provider.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBar(
      {Key key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _color;
  var _statusStyle;
  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    var themeProvider = context.read<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }

    print(
        "themeProvider的模式${themeProvider.isDark()} ${_color} ${_statusStyle}");

    _statusBarInit();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusBarInit() {
    changeStatusBar(color: _color, statusStyle: _statusStyle);
    // FlutterStatusbarManager.setColor(widget.color, animated: false);
    // FlutterStatusbarManager.setStyle(
    //     widget.statusStyle == StatusStyle.DARK_CONTENT
    //         ? StatusBarStyle.DARK_CONTENT
    //         : StatusBarStyle.LIGHT_CONTENT);
  }
}
