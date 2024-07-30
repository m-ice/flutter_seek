import 'package:flutter/material.dart';
import 'dart:io';

class CusBehavior extends ScrollBehavior {

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildOverscrollIndicator(context, child, details);
  }

  // @override
  // Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
  //   if (Platform.isAndroid || Platform.isFuchsia) return child;
  //   return super.buildScrollbar(context, child, details);
  // }
}
