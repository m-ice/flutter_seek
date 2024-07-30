import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_base_config/cus_behavior.dart';
import 'package:flutter_d0601/app_style/font_style.dart';


/// 图片加载异常提示组件
class ImageErrorWidget extends StatelessWidget {
  final double height;
  final double width;
  final String? error;
  const ImageErrorWidget({Key? key, required this.height, required this.width, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.withOpacity(0.5),
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
                child: Icon(Icons.error,size: width*0.36,color: Colors.grey,)),
            Expanded(
              flex: 2,
              child: ScrollConfiguration(
                behavior: CusBehavior(),
                child: ListView(
                  children: [
                    Text("Load of images failed\n ${error??''}",style: getFontStyle(color: Colors.white),
                      textAlign: TextAlign.center,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
