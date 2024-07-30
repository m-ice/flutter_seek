import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/app_colors.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

final networkUrlReg=RegExp('^http');
class BackGroundWidget extends StatelessWidget {
  final String backGroundName;
  final String? title;
  final TextStyle? titleStyle;
  final Widget child;
  final bool unpackBack;
  final bool back;
  final Color? backColor;
  final bool titleCenter;
  final Function? onBack;
  final bool unpackMasking;
  final Color? packMasColor;
  final Gradient? gradient;
  final Widget? rightButton;
  const BackGroundWidget({Key? key,required this.backGroundName,this.title,this.titleStyle,this.titleCenter=false,required
  this.child,this.unpackBack=false,this.back=true,
    this.unpackMasking=false,this.gradient,this.onBack, this.packMasColor, this.rightButton, this.backColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: ImageWidget(
            url:networkUrlReg.hasMatch(backGroundName)?backGroundName:ResourceUtil.getBackground(backGroundName),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),),
         if(unpackMasking) Positioned.fill(
           top: 0,
           bottom: 0,
           right: 0,
           left: 0,
           child:Container(
            decoration:  BoxDecoration(
              color: packMasColor??Colors.white.withOpacity(0.4),
                gradient: gradient?? RadialGradient(colors: const [AppColors.loginMaskColor1,AppColors.loginMaskColor2],
                  // begin: Alignment.bottomCenter,end: Alignment.topCenter,tileMode: TileMode.repeated
                  radius: 180.setRadius()
                ),
            ),
          ),),
          if(unpackBack)Positioned(
            top: MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).padding.left,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: titleCenter?MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
                children: [
                 back? Padding(
                   padding: EdgeInsets.only(left: 12.setWidth()),
                   child: IconButton(
                       onPressed: (){
                      if(onBack!=null){
                        onBack?.call();
                      }else{
                        Get.back();
                      }
          },tooltip: "Back",
                        icon: ImageWidget(url: ResourceUtil.getAppPageIcon('arrow_left'),height: 15.setHeight(),color: backColor,)
                   ),
                 ):SizedBox(width: 24.setWidth(),height: kToolbarHeight,),
                  if(title!=null)Text(
                    title!,
                    style: titleStyle??getFontStyle(
                        fontHeight: 1.2,
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                    ),
                  ),
                  if(titleCenter)
                    rightButton??Padding(padding: EdgeInsets.only(left: 16.setWidth()+MediaQuery.of(context).padding.left,
                        right: 28.setWidth()+MediaQuery.of(context).padding.right),
                      child: const Text(''),
                    ),
    //                 IconButton(
    //                     padding: ,
    //                     onPressed: (){
    //
    // },tooltip: "Back", icon: const Icon(Icons.arrow_back_outlined,color: Colors.transparent,)),
                ],
              ),
            ),),
          // if(title!=null)Positioned(
          //   child: ,
          // ),
          Positioned(
              top: unpackBack?kToolbarHeight.setHeight():0,
              // top:0,
              bottom: 0,
              left: 0,
              right: 0,
              // right: MediaQuery.of(context).padding.right,
              // left: MediaQuery.of(context).padding.left,
              child: SafeArea(
                child: child,
              )),
        ],
      ),
    );
  }
}
