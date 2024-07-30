import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/app_colors.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

/// 不扩张的按钮
class InnerInkWellWidget extends StatelessWidget {
  final Function? onTap;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final String title;
  final TextStyle? titleStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Color? backGroundColor;
  const InnerInkWellWidget({Key? key, this.onTap, this.gradient, required this.title, this.titleStyle, this.borderRadius, this.padding, this.backGroundColor, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          onTap?.call();
        },
        borderRadius: borderRadius??BorderRadius.all(Radius.circular(20.setRadius())),
        child: Ink(
          padding: padding??EdgeInsets.symmetric(vertical: 8.setHeight(),horizontal: 16.setWidth()),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backGroundColor??AppColors.bacKGroundColor3,
            borderRadius: borderRadius??BorderRadius.all(Radius.circular(20.setRadius())),
            gradient: gradient,
          ),
          child: Text(title,
            textAlign: TextAlign.center,
            style: titleStyle??getFontStyle(
              fontSize: 16,
              fontHeight: 1.2,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: AppColors.textColor1,
            ),),
        ),
      ),
    );
  }
}