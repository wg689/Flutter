import 'package:flutter/material.dart';
import 'package:flutter_bili_app/navigator/bottom_navigator.dart';
import 'package:flutter_bili_app/page/dark_mode_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';

typedef RouteChnageListener(RouteStatusInfo current, RouteStatusInfo pre);

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

/// 获取touteStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

//自定义的路由封装 ,路由状态
enum RouteStatus { login, registration, home, detail, unknow, darkMode }

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknow;
  }
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;
  RouteStatusInfo(this.routeStatus, this.page);
}

/// 监听路由页面的跳转
/// 感知当前的页面是否压后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator _instance;

  RouteJumpListener _routeJump;
  List<RouteChnageListener> _listenners = [];
  RouteStatusInfo _current;

// 首页底部tab
  RouteStatusInfo _bottomTab;

  HiNavigator._();

  RouteChnageListener get listener => null;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance;
  }

  /// 首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab);
  }

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  /// 监听路由页面的跳转
  void addListener(RouteChnageListener listener) {
    if (!_listenners.contains(listener)) {
      _listenners.add(listener);
    }
  }

  RouteStatusInfo getCurrent() {
    return _current;
  }

  /// 移除监听
  void removeListener(RouteJumpListener listener) {
    _listenners.remove(listener);
  }

  /// 通知路由页面的变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) {
      return;
    }
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab;
    }
    print("hi_navigator:current:${current.page}");
    print("hi_navigator:pre:${_current?.page}");

    _listenners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map args}) {
    print("_routeJump ${_routeJump} , routeStatus ${routeStatus}");
    _routeJump.onJumpTo(routeStatus, args: args);
  }
}

///抽象类提供Hinavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

///定义路由跳转逻辑实现功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;
  RouteJumpListener({this.onJumpTo});
}
