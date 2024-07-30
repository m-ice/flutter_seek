import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

TextStyle getFontStyle({
  double fontSize=10,
  FontWeight fontWeight=FontWeight.w400,
  double letterSpacing=0,
  FontStyle fontStyle=FontStyle.normal,
  double fontHeight=1.2,
  String fontFamily="Urbanist",
  TextOverflow? overflow,
  TextDecorationStyle? decorationStyle,
  TextDecoration? decoration,
  Color? color}){
  return TextStyle(
    color: color??const Color(0xFF212121),
    fontWeight: fontWeight,
    fontSize: fontSize.setFontSize(),
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing.setWidth(),
    height: fontHeight.setHeight(),
    overflow: overflow,
    decoration: decoration, //文字加横线
      decorationStyle:decorationStyle,
  );
}