import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function? onTap;
  final String title;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final double? width;
  const CustomButtonWidget({Key? key, this.onTap, required this.title, this.textStyle, this.decoration, this.padding, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child:InkWell(
        onTap: (){
          onTap?.call();
        },
        borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
        child: Ink(
          padding: padding??EdgeInsets.symmetric(vertical: 8.setWidth()),
          decoration:decoration?? BoxDecoration(
              color: const Color(0xFFDAB367),
              borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
          ),
          width: width??200.setWidth(),
          child: Text(title,
              textAlign: TextAlign.center,
              style: textStyle??getFontStyle(
              fontSize: 16,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontHeight: 1.4,
              color: Colors.white
          ),),
        ),
      ),
    );
  }
}
