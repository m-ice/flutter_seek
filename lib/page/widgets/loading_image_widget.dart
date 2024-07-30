import 'package:flutter/material.dart';

import '../../utils/resource_util.dart';
import 'image_widget.dart';


class LoadingImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? path;
  const LoadingImageWidget({Key? key, this.width, this.height, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
    color: Colors.transparent,
    child: ImageWidget(url: path??ResourceUtil.getAppPageIcon('loading'),width: width,height: height,),
    //
    // SizedBox(
    //   // width: width!=null?width!/2:null,
    //   // height: height!=null?height!/2:null,
    //   width: width,
    //   height: height,
    //   child: Center(
    //       child: ImageWidget(url: ResourceUtil.getAppPageIcon('loading',type: '.gif'),width: width,height: height,)
    //     // CircularProgressIndicator(
    //     //   strokeWidth: 2,
    //     // ),
    //   ),
    // ),
    );
  }
}
