import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final String categoryName;
  final List<BannerMo> bannerList;

  const HomeTabPage({Key key, this.name, this.bannerList, this.categoryName})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name),
    );
  }
}
