// import 'package:flutter/material.dart';
//
// class IconTextRichWidget extends StatelessWidget {
//   final String title;
//   const IconTextRichWidget({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Text.rich(
//           TextSpan(
//               children: [
//                 WidgetSpan(child: Padding(
//                   padding: EdgeInsets.only(top: 4.setWidth(),bottom: 4.setWidth(),right: 4.setWidth(),left: 2),
//                   child: Container(
//                     width: 8.setWidth(),
//                     height: 8.setWidth(),
//                     decoration: BoxDecoration(
//                         color: const Color(0xFF4ADE80),
//                         borderRadius: BorderRadius.all(Radius.circular(15.setRadius()))
//                     ),
//                   ),
//                 )),
//                 TextSpan(
//                   text: 'Online Now',style: getFontStyle(
//                     color: const Color(0xFF757575),
//                     fontWeight: FontWeight.w500,fontSize: 16,fontHeight: 1.4,letterSpacing: 0.2),
//                 )
//               ]
//           )
//       ),
//     );
//   }
// }
