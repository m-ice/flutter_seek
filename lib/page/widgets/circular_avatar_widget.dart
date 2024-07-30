import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';


/// 用户头像widget
class CircularAvatarWidget extends StatelessWidget {
  final double size;
  final dynamic url;
  const CircularAvatarWidget({Key? key, required this.size, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size/2),
        child: ImageWidget(
          url: url,
          width: size,
          height: size,
        ),
      ),
    );
  }
}

