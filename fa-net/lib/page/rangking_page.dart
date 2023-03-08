import 'package:flutter/material.dart' hide NavigationBar;
import 'package:flutter_bili_app/http/dao/ranking_dao.dart';
import 'package:flutter_bili_app/page/ranking_tab_page.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/HiTab.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
    RankingDao.get("like");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildNavigationBar(), _buildTableView()],
      ),
    );
  }

  _buildNavigationBar() {
    return NavigationBar(
        child: Container(
      alignment: Alignment.center,
      child: _tabBar(),
      decoration: bottomBoxShadow(),
    ));
  }

  _tabBar() {
    return HiTab(
      TABS.map<Tab>((tab) {
        return Tab(text: tab['name']);
      }).toList(),
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
    );
  }

  // _buildTableView() {
  //   return Flexible(
  //       child: Container(
  //     color: Colors.red,
  //   ));
  // }
  _buildTableView() {
    return Flexible(
        child: TabBarView(
            controller: _controller,
            children: TABS.map((tab) {
              return RankingTabPage(sort: tab['key']);
            }).toList()));
  }
}
