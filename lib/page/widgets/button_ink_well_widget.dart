import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

class ButtonInkWellWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool changeColor;
  final TextStyle? textStyle;
  final Gradient gradient;
  final Color buttonBackGroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  const ButtonInkWellWidget({Key? key,
    required this.onTap,
    required this.title,
    this.borderRadius,
    this.textStyle,
    this.padding,
    required this.changeColor,
    this.gradient=const LinearGradient(
      colors: [Color(0xFF3A89FF),Color(0xFF7F30FF),Color(0xFFDB3EFF)],
      // stops: [0,0.5,1]
    ),
    this.buttonBackGroundColor=const Color(0xFFD8D8D8)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: (){
            onTap.call();
          },
        // splashColor: buttonBackGroundColor,
        borderRadius: borderRadius??BorderRadius.all(Radius.circular(10.setRadius())),
          child: Ink(
            padding: padding??EdgeInsets.symmetric(vertical: 14.setHeight(),),
            decoration: BoxDecoration(
              color: buttonBackGroundColor,
              borderRadius: borderRadius??BorderRadius.all(Radius.circular(10.setRadius())),
              gradient: changeColor?gradient:null,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(title,
                style: textStyle??getFontStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontHeight: 1.2
              ),),
            ),
          ),
        ),
    );
  }
}

