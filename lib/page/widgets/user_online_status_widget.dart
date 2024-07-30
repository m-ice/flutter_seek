import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

import '../../app_style/font_style.dart';

/// 用户在线状态widget
class UserOnlineStatusWidget extends StatelessWidget {
  /// 用户在线状态 1：在线
  final int state;
  final double fontSize;
  final String? title;
  final Color? fontColor;
  const UserOnlineStatusWidget({Key? key, this.state=1, this.fontSize=16, this.fontColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(state){
      case 1:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 8.setWidth(),
              height: 8.setWidth(),
              margin: EdgeInsets.only(right: 7.setWidth(),left: 3.5.setWidth()),
              decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80),
                  borderRadius: BorderRadius.all(Radius.circular(15.setRadius()))
              ),
            ),
            Text(title??'Online Now',style: getFontStyle(color: fontColor??Colors.white,fontWeight: FontWeight.w500,fontSize: fontSize,
                fontHeight: 1.4,letterSpacing: 0.2),),
          ],
        );
    }
    return Container();
  }
}
