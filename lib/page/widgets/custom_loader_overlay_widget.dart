import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

import '../../app_style/app_colors.dart';


/// 自定义加载弹窗
class CustomLoaderOverlayWidget extends StatefulWidget {
  final Widget child;
  final bool loading;
  final double? progressValue;
  const CustomLoaderOverlayWidget({Key? key, required this.child, required this.loading, this.progressValue}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomLoaderOverlayWidgetState createState() => _CustomLoaderOverlayWidgetState();
}

class _CustomLoaderOverlayWidgetState extends State<CustomLoaderOverlayWidget> with TickerProviderStateMixin{

  Animation<Color?>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(duration: const Duration(seconds: 1), vsync: this,);
    animation=ColorTween(begin: AppColors.maskColor2.withOpacity(0.6),end: AppColors.maskColor3).animate(animationController!);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  int popCount=0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:  Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: WillPopScope(
              onWillPop: widget.loading?()async{
                if(popCount==1){
                  return true;
                }
                Future.delayed(const Duration(milliseconds: 1800),(){
                  popCount=0;
                });
                return false;
              }:null,
              child: widget.child,
            )
          ),
          if(widget.loading)  Positioned.fill(child: OverflowBox(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.setWidth()),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
                    ),
                    child: SizedBox(
                      width: 66.setWidth(),
                      height: 66.setWidth(),
                      child: CircularProgressIndicator(
                        strokeWidth: 4.5.setWidth(),
                        valueColor: animation,
                        color: AppColors.maskColor3.withOpacity(0.6),
                        backgroundColor:  AppColors.maskColor3.withOpacity(0.3),
                        value: widget.progressValue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          // if(widget.loading)Positioned.fill(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     color: Colors.black.withOpacity(0.09),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           padding: EdgeInsets.all(16.setWidth()),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
          //           ),
          //           child: SizedBox(
          //             width: 66.setWidth(),
          //             height: 66.setWidth(),
          //             child: CircularProgressIndicator(
          //                 strokeWidth: 4.5.setWidth(),
          //                 valueColor: animation,
          //                 color: AppColors.maskColor3.withOpacity(0.6),
          //                 backgroundColor:  AppColors.maskColor3.withOpacity(0.3),
          //               value: widget.progressValue,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),)
        ],
      ),
    );
  }
}
