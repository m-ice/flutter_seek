import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

class IconTextInkWellWidget extends StatelessWidget {
  final String? iconPath;
  final String title;
  final Function? onTap;
  final double? iconSize;
  final EdgeInsets? textPadding;
  final EdgeInsets? iconPadding;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final List<Color>? colors;
  final Color? iconColor;
  const IconTextInkWellWidget({Key? key, this.iconPath, required this.title, this.onTap, this.iconSize,
    this.textPadding, this.iconPadding, this.textStyle, this.colors, this.borderRadius, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          onTap?.call();
        },
        splashColor: (colors!=null&&colors!.isNotEmpty)?colors![0]:Theme.of(context).splashColor,
        borderRadius: borderRadius??BorderRadius.all(Radius.circular(27.setRadius())),
        child: Ink(
          // alignment: Alignment.center,
          padding: textPadding??EdgeInsets.symmetric(vertical: 9.setHeight()),
          decoration: BoxDecoration(
            // color: backGroundColor??const Color(0xFF3F80FF),
            borderRadius: borderRadius??BorderRadius.all(Radius.circular(27.setRadius())),
            gradient: (colors!=null&&colors!.isNotEmpty)?LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: colors!
            ):null,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               if(iconPath!=null) Padding(
                  padding: iconPadding??EdgeInsets.only(right: 8.setWidth()),
                  child: ImageWidget(url: iconPath,
                    width: iconSize??24.setWidth(),
                    // height: iconSize??24.setWidth(),
                    color: iconColor??Colors.white,
                  ),
                ),
                Text(title,style:textStyle?? getFontStyle(fontSize: 18,fontWeight: FontWeight.w700,
                    fontHeight: 1.4,letterSpacing: 0.2,color: Colors.white),
                textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
