import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';

import '../../app_style/font_style.dart';
import '../../utils/resource_util.dart';
import 'image_widget.dart';

/// 投诉选项
class ReportChoiceItemWidget extends StatelessWidget {
  final String choiceStatus;
  final String reportName;
  final Function? onTap;

  const ReportChoiceItemWidget({Key? key, this.choiceStatus='', required this.reportName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ParentInkWellWidget(
              onTap: (){
                onTap?.call(reportName);
              },
              child: Padding(
                padding: EdgeInsets.all(6.setWidth()),
                child: ImageWidget(url: ResourceUtil.getAppPageIcon(choiceStatus==reportName?'single_choice':'un_single_choice'),width: 20.setWidth(),),
              )),Text(reportName,
            style: getFontStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontHeight: 1.4,
                letterSpacing: 0.2
            ),),
        ],
      ),
    );
  }
}
