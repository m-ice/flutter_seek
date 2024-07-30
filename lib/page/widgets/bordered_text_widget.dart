import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

///带边框的文本widget
class BorderedTextWidget extends StatelessWidget {
  /// 文本内容
  final String text;
  /// 文本样式
  final TextStyle? textStyle;
  /// 边框样式
  final Border? border;
  /// 圆角
  final BorderRadius? borderRadius;
  /// 内边距
  final EdgeInsets? padding;
  /// 填充背景
  final Color? fillColor;
  /// 默认文本颜色
  final Color? textColor;
  const BorderedTextWidget({Key? key, required this.text, this.textStyle, this.border, this.borderRadius,this.padding, this.fillColor, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding??EdgeInsets.only(left: 12.setWidth(),right: 12.setWidth(),top: 4.setHeight(),bottom: 6.setHeight()),
      decoration: BoxDecoration(
        color: fillColor??Colors.transparent,
          borderRadius: borderRadius?? BorderRadius.all(Radius.circular(10.setRadius())),
          border: border??Border.all(width: 1.setWidth(),color: const Color(0xFF757575))
      ),
      child: Text(text,style: textStyle??getFontStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontHeight: 1.4,
        letterSpacing: 0.2,
        color: textColor??const Color(0xFF757575),
      ),),
    );
  }
}

///带边框与点击事件的文本widget
class BorderedTextInkWellWidget extends StatelessWidget {
  /// 文本内容
  final String text;
  /// 文本样式
  final TextStyle? textStyle;
  /// 边框样式
  final Border? border;
  /// 圆角
  final BorderRadius? borderRadius;
  /// 内边距
  final EdgeInsets? padding;
  /// 点击事件
  final Function? onTap;
  /// 填充背景
  final Color? fillColor;
  /// 默认文本颜色
  final Color? textColor;
  const BorderedTextInkWellWidget({Key? key, required this.text, this.textStyle, this.border, this.borderRadius, this.padding, this.onTap, this.fillColor, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          onTap?.call();
        },
        borderRadius: borderRadius??const BorderRadius.all(Radius.circular(8.0)),
        child: BorderedTextWidget(
          text: text,
          textStyle: textStyle,
          border: border,
          borderRadius: borderRadius,
          padding: padding,
          fillColor: fillColor,
        ),
      ),
    );
  }
}
