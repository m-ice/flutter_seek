import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/utils/db_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'app.dart';

void main()async{
  // WidgetsFlutterBinding 承担各类的初始化以及功能配置
  // WidgetsFlutterBinding.ensureInitialized();

  /// 使用 flutter 异常上报
  FlutterBugly.postCatchedException(() async{
    // 如果需要 ensureInitialized，请在这里运行。
    WidgetsFlutterBinding.ensureInitialized();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    if (Platform.isAndroid) {
      //statusBarIconBrightness: Brightness.light
      //     //light:黑色图标 dark：白色图标
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
          .copyWith(statusBarBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    await CustomCacheUtil.getInstance();

    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      // var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
      //     AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      // var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
      //     AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
      //
      // if (swAvailable && swInterceptAvailable) {
      //   AndroidServiceWorkerController serviceWorkerController =
      //   AndroidServiceWorkerController.instance();
      //
      //   await serviceWorkerController
      //       .setServiceWorkerClient(AndroidServiceWorkerClient(
      //     shouldInterceptRequest: (request) async {
      //       print(request);
      //       return null;
      //     },
      //   ));
      // }
    }
    // DBUtil.initDB();
    DBService.getInstance();
    runApp(const MyApp());
    FlutterBugly.init(
      androidAppId: Constants.bugAndroidAppId,
      iOSAppId: Constants.bugIOSAppId,
    );
  });
  // runApp(const MyApp());
  // FlutterCatchError.run(const MyApp());
}

