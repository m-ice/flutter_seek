import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/i18n/app_language.dart';
import 'package:flutter_d0601/page/router/custom_route_observer.dart';
import 'package:flutter_d0601/page/router/page_switching_effect.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GetMaterialApp(
        title: Constants.appTitle,
        debugShowCheckedModeBanner: false,
        translations: AppLanguage(),
        customTransition: PageSwitchingEffect(),
        locale: ui.window.locale, // 将会按照此处指定的语言翻译
        fallbackLocale: const Locale('en', 'US'),   // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Urbanist"
        ),
        builder: BotToastInit(),
        getPages: RouterManager.routerList,
        initialRoute: RouterManager.splash,
        navigatorObservers: [CustomRouteObserver()],// 设置路由观察者
      ),
    );
  }
}