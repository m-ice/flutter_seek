import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

class OverlayEntryGlobalConfigController extends GetxController{
  OverlayEntry? overlayEntry;

  /// 删除插入页面的小组件
  disposeOverLayEntry(){
    if(overlayEntry!=null){
      overlayEntry!.remove();
      overlayEntry=null;
      update();
    }
  }
  ///['保存','取消']
  assemblyPage({required List<String> tipList, Function? onTap,required DragStartDetails details,required BuildContext context}){
    overlayEntry=createSaveImageOverlayEntry(tipList: tipList, details: details);
    update();
    if(overlayEntry!=null){
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  /// 保存图片
OverlayEntry createSaveImageOverlayEntry({required List<String> tipList,required DragStartDetails details, Function? onTap}){
  return OverlayEntry(builder: (cx){
    return Positioned(
      top: details.localPosition.dy,
        left: details.localPosition.dx,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.setHeight()),
           decoration: BoxDecoration(
               color: Colors.black.withOpacity(0.3),
             borderRadius: BorderRadius.all(Radius.circular(16.setRadius()))
           ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tipList.length, (index){
                return ParentInkWellWidget(
                  onTap: (){
                    onTap?.call(tipList[index]);
                  },
                    borderRadius: BorderRadius.zero,
                  child: Ink(
                    padding: EdgeInsets.symmetric(vertical: 8.setHeight(),horizontal: 24.setWidth()),

                    child: Text(tipList[index],style: getFontStyle(fontHeight: 1.2,
                    fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white,letterSpacing: 0.2),),
                  ),
                );
              }),
            ),
          ),
        ));
  });
}
}