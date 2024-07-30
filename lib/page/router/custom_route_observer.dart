
import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/utils/log_util.dart';

class CustomRouteObserver extends NavigatorObserver{
  @override
  void didPop(Route route, Route? previousRoute) {

    LogUtil.logUtil("${route.toString()}=>${previousRoute.toString()}",tag: "路由观察者:didPop");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    LogUtil.logUtil("${route.toString()}=>${previousRoute.toString()}",tag: "路由观察者:didPush");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    LogUtil.logUtil("${route.toString()}=>${previousRoute.toString()}",tag: "路由观察者:didRemove");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    LogUtil.logUtil("${oldRoute.toString()}=>${newRoute.toString()}",tag: "路由观察者:didReplace");
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    LogUtil.logUtil("${route.toString()}=>${previousRoute.toString()}",tag: "路由观察者:didStartUserGesture");
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
  }

}