import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';

toast(String? msg, {AlignmentGeometry? align,Duration? duration,Widget? iconWidget}) {
  BotToast.showText(
      text: msg ?? '',
      textStyle: getFontStyle(
        fontSize: 16,
        color: const Color(0xFFFFFFFF),
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
      ),
      align: align ?? Alignment.topCenter,
      contentColor: Colors.black87,
      duration: duration ?? const Duration(seconds: 2),
    iconWidget: iconWidget
  );
}

toastCenter(String? msg,{Widget? iconWidget}) {
  BotToast.showText(
    text: msg ?? '',
    textStyle: getFontStyle(
      fontSize: 16,
      color: const Color(0xFFFFFFFF),
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
    ),
    align: Alignment.center,
    contentColor: Colors.black87,
    iconWidget: iconWidget
  );
}

toastBottom(String? msg, {Widget? iconWidget}) {
  BotToast.showText(
    text: msg ?? '',
    textStyle: getFontStyle(
        fontSize: 16,
        color: Colors.black,
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
    ),
    align: const Alignment(0, 0.8),
    contentColor: Colors.white,
    iconWidget: iconWidget
  );
}

error(String? msg, {AlignmentGeometry? alignmentGeometry,Duration? duration,Widget? iconWidget}) {
  BotToast.showText(
    text: msg ?? '',
    textStyle:  getFontStyle(
        color: const Color(0xFFFAF8F8),
        fontSize: 16,
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
    ),
    align: alignmentGeometry ?? Alignment.topCenter,
    contentColor: const Color(0xfff56c6c),
    duration: duration ?? const Duration(seconds: 3),
    iconWidget: iconWidget
  );
}

success(String? msg, {AlignmentGeometry? alignmentGeometry,duration,Widget? iconWidget}) {
  BotToast.showText(
    text: msg ?? '',
    textStyle: getFontStyle(
        color: const Color(0xFF50A126),
        fontSize: 16,
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
    ),
    align: alignmentGeometry ?? Alignment.topCenter,
    contentColor: const Color(0xFFE9FAE2),
    duration: duration ?? const Duration(seconds: 3),
    iconWidget: iconWidget
  );
}

warning(String? msg, {AlignmentGeometry? alignmentGeometry,Widget? iconWidget}) {
  BotToast.showText(
    text: msg ?? '',
    textStyle:  getFontStyle(
        color: Colors.white,
        fontSize: 16,
        fontHeight: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500
    ),
    align: alignmentGeometry ?? Alignment.topCenter,
    contentColor: const Color(0xFFE08804),
    iconWidget: iconWidget,
  );
}
