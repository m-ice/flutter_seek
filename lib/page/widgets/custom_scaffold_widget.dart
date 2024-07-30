import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/app_colors.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 自定义加载脚手架
class CustomScaffoldWidget extends StatefulWidget {
  final Widget child;
  final OnRefreshCallback? onRefresh;
  final bool reverse;
  final OnRefreshCallback? onLoad;

  /// 是否使用默认加载进度条
  final bool useDefaultLoading;
  final bool loadPress;
  const CustomScaffoldWidget({Key? key, required this.child, this.onRefresh, this.onLoad,this.reverse=false
    ,this.useDefaultLoading=false, this.loadPress=true}) : super(key: key);

  @override
  State<CustomScaffoldWidget> createState() => _CustomScaffoldWidgetState();
}

class _CustomScaffoldWidgetState extends State<CustomScaffoldWidget>  with TickerProviderStateMixin {
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
  @override
  Widget build(BuildContext context) {
    return widget.loadPress?Material(
      color: Colors.white,
      child: LoaderOverlay(
        useDefaultLoading: widget.useDefaultLoading,
        overlayOpacity: 0.4,
        overlayColor: Colors.black.withOpacity(0.4),
        overlayWidget:  Align(
          child: Container(
            width: 100.setWidth(),
            height: 100.setWidth(),
            padding: EdgeInsets.all(24.setWidth()),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
              // gradient:  LinearGradient(
              //   colors: [Color(0xFF3A89FF),Color(0xFF7F30FF),Color(0xFFD83EFF)],
              // )
            ),
            child:CircularProgressIndicator(
                strokeWidth: 4.5.setWidth(),
                valueColor: animation,
                color: AppColors.maskColor3.withOpacity(0.6),
                backgroundColor:  AppColors.maskColor3.withOpacity(0.3)
            ),
            //
            // ShaderMask(
            //   blendMode: BlendMode.modulate,
            //   shaderCallback: (bounds) => RadialGradient(
            //       center: Alignment.topLeft,
            //       radius: 0.01.setRadius(),
            //       colors: const [AppColors.maskColor1,AppColors.maskColor2,AppColors.maskColor2],
            //       tileMode: TileMode.mirror
            //   ).createShader(bounds),
            //   child: CircularProgressIndicator(
            //       strokeWidth: 4.5.setWidth(),
            //       color: AppColors.maskColor3.withOpacity(0.6),
            //       backgroundColor:  AppColors.maskColor3.withOpacity(0.3)
            //   ),
            // ),
          ),
        ),
        child: widget.child is ListView||widget.child is GridView?EasyRefresh(
          onLoad: widget.onLoad,
          onRefresh: widget.onRefresh,
          header: widget.reverse?MaterialHeader(
            valueColor: animation,
            enableHapticFeedback: true,
          ):ClassicalHeader(
            textColor: const Color(0xFFD83EFF),
            infoColor: const Color(0xFF7F30FF)
          ),
          // footer: ClassicalFooter(
          //     textColor: const Color(0xFFD83EFF),
          //     infoColor: const Color(0xFF7F30FF),
          // ),
          footer: MaterialFooter(
            enableInfiniteLoad: false,
            valueColor: animation,
            enableHapticFeedback: true,
          ),
          child: widget.child,
        ):widget.child,
      ),
    ):widget.child is ListView||widget.child is GridView?EasyRefresh(
      onLoad: widget.onLoad,
      onRefresh: widget.onRefresh,
      header: widget.reverse?MaterialHeader(
        valueColor: animation,
        enableHapticFeedback: true,
      ):ClassicalHeader(
          textColor: const Color(0xFFD83EFF),
          infoColor: const Color(0xFF7F30FF)
      ),
      // footer: ClassicalFooter(
      //     textColor: const Color(0xFFD83EFF),
      //     infoColor: const Color(0xFF7F30FF),
      // ),
      footer: MaterialFooter(
        enableInfiniteLoad: false,
        valueColor: animation,
        enableHapticFeedback: true,
      ),
      child: widget.child,
    ):widget.child;
  }
}
