
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';

/// 路由动画效果
class PageSwitchingEffect extends CustomTransition{
  @override
  Widget buildTransition(BuildContext context, Curve? curve, Alignment? alignment, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: false,
      child: FadeTransition(
        opacity: animation,
        alwaysIncludeSemantics: false,
        child: child,
      ),
    );
  }
  
}