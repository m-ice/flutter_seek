import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';

class ChatMessageMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route){
    // print("哈哈哈哈哈哈或${Constants.isOpenMembership}-----${Constants.alreadyChatDataList.length}");
    if((!Constants.isOpenMembership)&&(!Constants.isAuditOrNot)&&Constants.alreadyChatDataList.length>=5){
      return  const RouteSettings(name: '${RouterManager.vipOfOpenOrDetails}?requireVip=true');
    }
    return null;
  }

}
