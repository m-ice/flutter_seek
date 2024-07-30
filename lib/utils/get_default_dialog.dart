import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/app_colors.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/widgets/inner_ink_well_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

/// 提示窗
void getDefaultDialog({
  String? title,TextStyle? titleStyle,
  Widget? content,bool barrierDismissible=true,
  bool onWillPop=true,
  required BuildContext context, String? middleText,
  TextStyle? middleTextStyle, String? cancelTitle,
  Color? cancelTitleBackGroundColor,
  TextStyle? cancelTextStyle,
  Gradient? cancelGradient, Function? cancelOnTap,
  String? confirmTitle,TextStyle? confirmTextStyle,
  Widget? inkWellWidget,EdgeInsets? confirmPadding,
  BorderRadius? buttonBorderRadius,
  EdgeInsets? buttonBottomPadding,
  Gradient? confirmGradient, Function? confirmOnTap,
  EdgeInsets? contentPadding,
}){
  Get.defaultDialog(
    titlePadding: EdgeInsets.zero,
    barrierDismissible: barrierDismissible,
    onWillPop: ()async{
      return onWillPop;
    },
    contentPadding: contentPadding??EdgeInsets.symmetric(vertical: 24.setWidth(),horizontal: 16.setWidth()),
    title: title??'',
    titleStyle: titleStyle??getFontStyle(
        fontSize: 0
    ),
    content: content??Text(middleText??'',
      textAlign: TextAlign.center,
      style: middleTextStyle??getFontStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontHeight: 1.4,
          letterSpacing: 0.2
      ),),
    actions: [
      if(inkWellWidget!=null)inkWellWidget,
      if(!(inkWellWidget!=null))Padding(
        padding: buttonBottomPadding??EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(cancelTitle!=null)InnerInkWellWidget(title: cancelTitle,
              backGroundColor: cancelTitleBackGroundColor??AppColors.bacKGroundColor2,
              borderRadius: buttonBorderRadius??BorderRadius.all(Radius.circular(20.setRadius())),
              width: 90.setWidth(),
              padding: EdgeInsets.symmetric(vertical: 8.setHeight()),
              titleStyle: cancelTextStyle??getFontStyle(
                fontSize: 16,
                fontHeight: 1.2,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: AppColors.textColor1,
              ),
              onTap: (){
                if(cancelOnTap!=null){
                  cancelOnTap.call();
                }else{
                  Get.back();}},
            ),
            if(confirmTitle!=null)InnerInkWellWidget(title: confirmTitle,
              backGroundColor: AppColors.bacKGroundColor3,
              gradient: confirmGradient,
              borderRadius: buttonBorderRadius??BorderRadius.all(Radius.circular(20.setRadius())),
              width: 90.setWidth(),
              padding: confirmPadding??EdgeInsets.symmetric(vertical: 8.setHeight()),
              titleStyle: cancelTextStyle??getFontStyle(
                fontSize: 16,
                fontHeight: 1.2,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: AppColors.textColor1,
              ),
              onTap: (){
                if(confirmOnTap!=null){
                  confirmOnTap.call();
                }else{
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    ],
  );
}
