import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

import '../../app_style/font_style.dart';
import '../../utils/resource_util.dart';
import 'button_ink_well_widget.dart';
import 'image_widget.dart';


class NoNewsWidget extends StatelessWidget {
  /// 背景图片
  final String? backGroundImage;
  final double? backGroundWidth;
  /// 提示内容
  final String? tips;
  final double? tipsWidth;
  final Gradient? gradient;
  final String? bottomMsg;
  final Function? onTap;
  final int onTapType;

  const NoNewsWidget({Key? key, this.backGroundImage, this.tips, this.gradient, this.onTap,
    this.backGroundWidth, this.tipsWidth, this.bottomMsg, this.onTapType=1}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(url: backGroundImage??ResourceUtil.getAppPageIcon("sed_top_2"),width: backGroundWidth??180.setWidth(),),
            SizedBox(
              width: tipsWidth??200.setWidth(),
              child: Text(tips??'No Likes yet',
                textAlign: TextAlign.center,
                style: getFontStyle(
                    fontSize: 14,
                    fontHeight: 1.4,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF757575),
                    letterSpacing: 0.2
                ),),
            ),
            SizedBox(height: 24.setHeight(),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.setWidth()),
              child: ButtonInkWellWidget(
                gradient: gradient??const LinearGradient(
                  colors: [Color(0xFF3A89FF),Color(0xFF7F30FF),Color(0xFFDB3EFF)],
                  // stops: [0,0.5,1]
                ),
                title: bottomMsg??'Go to match',
                onTap: (){
                  onTap?.call();
                }, changeColor: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
