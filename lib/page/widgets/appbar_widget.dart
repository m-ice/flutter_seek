import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/widgets/button_ink_well_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

import '../../utils/resource_util.dart';
import 'image_widget.dart';

// class AppBarWidget extends StatelessWidget {
//   final String title;
//   final double elevation;
//   final Function? onBack;
//   const AppBarWidget({Key? key, required this.title,this.elevation=0, this.onBack}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: elevation,
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         iconSize: 24.setWidth(),
//         icon: Icon(Icons.arrow_back_outlined,size: 24.setWidth(),),
//         onPressed: (){
//           onBack??  Get.back();
//         },
//       ),
//       title: Text(title,style: getFontStyle(
//         fontWeight: FontWeight.w700,
//         fontSize: 20,
//         fontHeight: 1.2
//       ),),
//     );
//   }
// }
getAppBarWidget({required BuildContext context,String? title,String? rightButtonTitle,
  Function? rightOnTap,
  double elevation=0,bool centerTitle=false, Function? onBack}){
  return AppBar(
    elevation: elevation,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: IconButton(
      tooltip: 'Back',
      iconSize: 24.setWidth(),
      // icon: Icon(Icons.arrow_back_outlined,size: 24.setWidth(),color: const Color(0xFF212121),),
      icon: ImageWidget(url: ResourceUtil.getAppPageIcon('arrow_left'),width: 20.setWidth(),color: const Color(0xFF212121),),
      onPressed: (){
        onBack??Get.back();
      },
    ),
    centerTitle: centerTitle,
    titleSpacing: -4.setWidth(),
    actions: [
      if(rightButtonTitle!=null)Padding(
          padding: EdgeInsets.only(top: 9.setHeight(),bottom: 9.setHeight(),right: 16.setWidth()),
          child: ButtonInkWellWidget(onTap: (){
            rightOnTap?.call();
          }, title: rightButtonTitle, changeColor: true,
              textStyle: getFontStyle(fontSize: 14,fontWeight: FontWeight.w700,color: const Color(0xFFFFFFFF),fontHeight: 1.4,letterSpacing: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(16.setRadius())),
            padding: EdgeInsets.symmetric(vertical: 4.setHeight(),horizontal: 20.setWidth()),
          )),
    ],
    title: Text(title??'',style: getFontStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontHeight: 1.2
    ),),
  );
}
