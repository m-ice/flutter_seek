import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

class BackGroundInkWidget extends StatelessWidget {
  final double? radius;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Widget child;
  final Function? onTap;
  const BackGroundInkWidget({Key? key, this.radius,this.gradient, this.backgroundColor, this.padding,
    required this.child, this.onTap, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius??56.setRadius())),
        child: Ink(
            padding: padding??EdgeInsets.all(16.setWidth()),
            width: width,height: height,
            decoration: BoxDecoration(
                color:  backgroundColor??Colors.white,
                gradient: gradient,
                borderRadius: BorderRadius.all(Radius.circular(56.setRadius()))
            ),
            child: child),
        onTap: (){
          onTap?.call();
        },
      ),
    );
  }
}
