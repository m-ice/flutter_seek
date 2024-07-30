import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
///全局异常的捕捉
class FlutterCatchError {
  static run(Widget app) {
    ///Flutter 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      ///TODO 线上环境
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        ///TODO 开发期间 print
        FlutterError.dumpErrorToConsole(details);
      }
    };

    setCustomErrorPage();

    runZonedGuarded(() {
      ///受保护的代码块
      runApp(app);
    }, (error, stack) => catchError(error, stack));
  }

  ///对搜集的 异常进行处理  上报等等
  static catchError(Object error, StackTrace stack) {
    if(kDebugMode){
      print("AppCatchError>>>>>>>>>>: $kReleaseMode"); //是否是 Release版本
      print('APP出现异常  message:$error,stackTrace：$stack');
    }
  }

  ///自定义异常页面
  static void setCustomErrorPage() {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      debugPrint(flutterErrorDetails.toString());
      String stError = flutterErrorDetails.exceptionAsString();
      return Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
              color: Colors.white,
              padding:  EdgeInsets.all(15.setWidth()),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(Icons.error,size: 55.setWidth(),color: Colors.orange,),
                    ),
                    Text("Current module exception${'，System diagnosis as：${stError.split(':').isNotEmpty?stError.split(':')[0]:''}'}，Please contact the administrator！",
                      textAlign: TextAlign.center,
                      style: getFontStyle(fontSize: 14,fontWeight: FontWeight.w500,fontHeight: 1.4,letterSpacing: 0.4),
                    ),
                    Text(
                      flutterErrorDetails.exceptionAsString(),
                      style: getFontStyle(color: Colors.blue, fontSize: 14),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              )
          ),
        ),
      );
    };
  }
}