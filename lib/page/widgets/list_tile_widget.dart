import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

import 'image_widget.dart';

class ListTileWidget extends StatelessWidget {
  final String? leftIconPath;
  final double? leftIconWidth;
  final double? leftIconHeight;
  final String title;
  final TextStyle? titleStyle;
  final String? rightIconPath;
  final double rightIconWidth;
  final double rightIconHeight;
  final double horizontalTitleGap;
  final double minVerticalPadding;
  final EdgeInsets? contentPadding;
  final Function? onTap;


  const ListTileWidget({Key? key,
    this.leftIconPath,
    this.leftIconWidth,
    this.leftIconHeight,
    required this.title,
    this.titleStyle,
    this.rightIconPath,
    this.rightIconWidth=24,
    this.rightIconHeight=24,
    this.horizontalTitleGap=8,
    this.onTap,
    this.minVerticalPadding=0, this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: ()=> onTap?.call(),
        leading: leftIconPath!=null?ImageWidget(
          url: '$leftIconPath',
          width: leftIconWidth!=null?leftIconWidth!.setWidth():leftIconWidth,
          height: leftIconHeight!=null?leftIconHeight!.setWidth():leftIconHeight,
        ):null,
        title: Text(title,style: titleStyle??getFontStyle(
            fontSize: 16,fontHeight: 1.4,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2
        ),),
        trailing: rightIconPath!=null?
        ImageWidget(
          url: "$rightIconPath",
          width: rightIconWidth.setWidth(),
          height: rightIconHeight.setWidth(),
        )
            :Icon(
          Icons.keyboard_arrow_right_outlined,
          color: const Color(0xFF9E9E9E),
          size: rightIconWidth.setWidth(),
        ),
        minVerticalPadding: minVerticalPadding.setHeight(),
        contentPadding: contentPadding??EdgeInsets.zero,
        minLeadingWidth: 0,
        horizontalTitleGap: horizontalTitleGap.setWidth(),
      ),
    );
  }
}
