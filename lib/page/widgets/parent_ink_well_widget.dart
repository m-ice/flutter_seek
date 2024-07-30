import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

class ParentInkWellWidget extends StatelessWidget {
  final Function? onTap;
  final Function? onTapDown;
  final Function? onTapUp;
  final Function? onTapCancel;
  final Function? onLongPress;
  final bool exitOnLongPress;
  final BorderRadius? borderRadius;
  final Widget? child;
  final EdgeInsets? textPadding;
  const ParentInkWellWidget({Key? key, this.onTap, this.borderRadius, this.child,
    this.textPadding, this.onTapDown, this.onTapUp, this.onTapCancel, this.onLongPress, this.exitOnLongPress=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onLongPress: exitOnLongPress?null:(){
          onLongPress?.call();
        },
        onTapDown: (v){
          onTapDown?.call();
        },
        onTapUp: (v){
          onTapUp?.call();
        },
        onTapCancel: (){
          onTapCancel?.call();
        },
        onTap: (){
          onTap?.call();
        },
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.3)),
        borderRadius: borderRadius??BorderRadius.all(Radius.circular(24.setRadius())),
        child: child??Container(
          padding: textPadding??EdgeInsets.all(4.setWidth()),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.48),
              borderRadius: BorderRadius.all(Radius.circular(24.setRadius()))
          ),
          child: Icon(Icons.close,color: Colors.white,size: 16.setWidth(),),
        ),
      ),
    );
  }
}
