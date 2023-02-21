import 'package:flutter/material.dart';
import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/http/request/test_request.dart';
import 'package:flutter_bili_app/model/owner.dart';
import 'package:flutter_bili_app/model/result.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'dart:convert';

import 'http/core/hi_net.dart';
import 'model/video_model';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
          return MaterialApp(
            home: widget,
            theme: ThemeData(primarySwatch: white),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigationKey;

  /// 为navigator 设置一个key 必要时候可以通过navigateKey.currentSttae 来获得
  BiliRouteDelegate() : navigationKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        this.videoModel = args['videoMo'];
      }
      notifyListeners();
    }));

    HiNet.getInstance().setErrorInterceptor((error) {
      if (error is NeedLogin) {
        HiCache.getInstance().setString(LoginDao.BOARDING_PASS, null);
        HiNavigator.getInstance().onJummpTo(RouteStatus.login);
      }
    });
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel videoModel;

// 开始
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }

    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(BottomNavigationBar());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages, page];
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      onWillPop: () async => !await navigationKey.currentState.maybePop(),
      child: Navigator(
          key: navigationKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast("请先登录");
                  return false;
                }
              }
            }
            if (!route.didPop(result)) {
              return false;
            }
            var tempPages = [...pages];
            pages.removeLast();
            HiNavigator.getInstance().notify(pages, tempPages);
            return true;
          }),
    );
  }

  RouteStatus get routeStatus {
    if (false) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      _routeStatus;
    }
  }

  bool get hasLogin => true;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  // @override
  // // TODO: implement navigatorKey
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();
}

class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}
