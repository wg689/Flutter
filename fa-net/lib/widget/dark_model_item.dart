import 'package:flutter/material.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/provider/theme_provider.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:provider/provider.dart';

class DarkModelItem extends StatefulWidget {
  @override
  _DarkModelItemState createState() => _DarkModelItemState();
}

class _DarkModelItemState extends State<DarkModelItem> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.read<ThemeProvider>();
    var icon = themeProvider.isDark()
        ? Icons.night_shelter_rounded
        : Icons.wb_sunny_rounded;
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            Text("夜间模式",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
                padding: EdgeInsets.only(top: 2, left: 10), child: Icon(icon))
          ],
        ),
      ),
    );
  }
}
