import 'dart:async';
import 'dart:convert';

import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/home_controller.dart';
import 'package:flutter_d0601/page/home/discover/model/chat_message_entity.dart';
import 'package:flutter_d0601/page/home/discover/model/friend_entity.dart';
import 'package:flutter_d0601/page/home/discover/model/quick_reply_messages_entity.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

import '../http/dio_service.dart';
import '../utils/db_util.dart';
import '../utils/new_message_prompt.dart';
import '../utils/operate_db_util.dart';
import 'r_cloud_im_base_controller.dart';

class  DiscoverController extends RCloudImBaseController{
  /// 当前索引
  int currentIndex=0;
  /// 页面控制器
  PageController  pageController=PageController(initialPage:0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Constants.eventBus.on('insertOrUpdateConversation', (args) {
      insertConversation(args);
    });
    quickReplyMessages();
  }
  /// 好友列表
  List<FriendEntity> friendList=[];
  /// 重新登录 或者 启动app 判断数据获取次数
  int feedback=0;
  getConversationsRecord({bool refresh=true})async{
    if(friendList.isEmpty){
      friendList =await DBUtil.selectRecordFriend();
      Constants.messageCount=0;
      for(FriendEntity friendEntity in friendList){
        Constants.messageCount+=(friendEntity.unreadCount??0);
      }
      Get.find<HomeController>().update();
    }
    if(rcImConnectionStatus!=RCIMIWConnectionStatus.connected){
      if(feedback<10){
        feedback++;
        Future.delayed(const Duration(milliseconds: 1200),(){
          getConversationsRecord();
        });
      }
    }else{
      LogUtil.logInfo('连接融云的状态onConnectionStatusChanged 6666：$rcImConnectionStatus');
      feedback=0;
      friendList =await DBUtil.selectRecordFriend();
      await getConversations(onSuccess: (list){
        // LogUtil.logUtil("获取的对话框222222");
        updateDialog(list);
      });
      getTotalUnreadCount(onSuccess: (t){
        Constants.messageCount=t??0;
        Get.find<HomeController>().update();
      });
    }
    update();
  }

  List<String> quickReplyMessagesList=[];
  /// quickReplyMessages-快捷回复消息列表
  quickReplyMessages()async{
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'appId':Constants.loginData!.userInfo!.appId,//本人应用id
      'userId':Constants.loginData!.userInfo!.userId,//本人用户长id
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QuickReplyMessagesEntity quickReplyMessagesEntity=await DioService<QuickReplyMessagesEntity>().quickReplyMessages(data);
    if(quickReplyMessagesEntity.success??false){
      quickReplyMessagesList=(quickReplyMessagesEntity.data??[]).map((e) => e.msgContent.toString()).toList();
      update();
    }
  }

  /// 更新对话
  updateDialog(List<RCIMIWConversation>? list)async{
    if((list??[]).isNotEmpty){
      for(RCIMIWConversation con in list??[]){
        LogUtil.logUtil("本地的对话框${jsonEncode(con.lastMessage)}");
        /// 筛选统计拉黑用户的未读消息
        if(Constants.blockDataList.indexWhere((element) => element==jsonDecode(con.lastMessage!.extra!)['angleUserId'].toString())!=-1){
          Constants.blockDataMessageCount+=con.unreadCount??0;
          Get.find<HomeController>().update();
          return ;
        }
        if(con.unreadCount!=null){
          if(con.unreadCount!<=20){
            await getHistoryMessage(
                pageSize: con.unreadCount??0,
                sentTime: con.lastMessage!.sentTime??DateTime.now().millisecondsSinceEpoch,
                targetId: con.targetId.toString(),onSuccess:(list){
                  if(list!=null&&list.isNotEmpty){
                    loopChatRecord(list);
                    update();
                  }
            }, onError: (int? code) {
              debugPrint('消息加载异常$code');
            });
          }else{
            int loop= ((con.unreadCount??0) / 20 - 0.5).round() + (((con.unreadCount??0) % 20) > 0 ? 1 : 0);
            int? time=con.lastMessage!.sentTime??DateTime.now().millisecondsSinceEpoch;
            for(int i=0;i<loop;i++){
              await getHistoryMessage(
                  pageSize: 20,
                  sentTime: time!,
                  targetId: con.targetId.toString(),onSuccess:(list){
                if(list!.isNotEmpty){
                  time=list[list.length-1].sentTime;
                  loopChatRecord(list);
                }
                update();
              }, onError: (int? code) {
                debugPrint('消息加载异常$code');
              });
            }
          }

        }

        /// 重置未读消息数
        int indexWhere=friendList.indexWhere((element) => element.targetId==con.targetId);
        if (indexWhere != -1) {
          if (con.unreadCount != friendList[indexWhere].unreadCount) {
            friendList[indexWhere].unreadCount = con.unreadCount;
            friendList[indexWhere].sentTime = con.lastMessage!.sentTime??DateTime.now().millisecondsSinceEpoch;
            friendList[indexWhere].receivedTime = con.lastMessage!.receivedTime??DateTime.now().millisecondsSinceEpoch;
            friendList[indexWhere].message = con.lastMessage!.toJson()['text'];
            /// 重置未读消息数
            DBUtil.updateRecordByTargetId([
              friendList[indexWhere].unreadCount,
              friendList[indexWhere].message,
              friendList[indexWhere].targetId
            ]);
            update();
          }
        } else {
          insertConversation(
              {"message": con.lastMessage}, messagePrompt: false,
              unreadCount: (con.unreadCount ?? 0));
        }
      }
    }else{
      Constants.messageCount=0;
      for(FriendEntity? friend in friendList){
        Constants.messageCount+=friend!.unreadCount??0;
        Get.find<HomeController>().update();
      }
      update();
    }
  }


  /// 插入新对话
  insertConversation(Map<String,dynamic> args,{bool messagePrompt=true,int unreadCount=0}){
    ///  是否统计未读消息
    if(messagePrompt){
      Constants.messageCount+=1;
      Get.find<HomeController>().update();
    }
    RCIMIWMessage message=args['message'];
    Map<String,dynamic> map={
      "landerUID": Constants.loginData!.userInfo!.id!.toString(),
      "message": message.toJson()['text'],
      "targetId": message.targetId.toString(),
      "appId": jsonDecode(message.extra!)['angleAppId'].toString(),
      /// 消息类型 0文本 1图片 2语音
      "messageType":message.messageType!=null?(message.messageType==RCIMIWMessageType.text?0:
      message.messageType==RCIMIWMessageType.voice?2:
      message.messageType==RCIMIWMessageType.image?1:-1):-1,
      "conversationType": 1,
      "userId":jsonDecode(message.extra!)['angleUserId'].toString(),
      "nickname": message.userInfo!.name.toString(),
      "portrait": message.userInfo!.portrait.toString(),
      "alias": message.userInfo!.alias.toString(),
      "extra": message.userInfo!.extra.toString(),
      "receivedTime": message.receivedTime,
      "sentTime": message.sentTime,
      "unreadCount": messagePrompt?1:0,
      "offLine": 1, /// message.offLine??
      "top": 0
    };
    FriendEntity friend=FriendEntity.fromJson(map);

    /// 弹窗提示来消息了
    if(messagePrompt){
      Constants.eventBus.existKey(key: 'newMessage_${message.targetId}',
          noExist: (){
            // HapticFeedback.selectionClick();
            NewMessagePrompt.newMessagePrompt(friend: friend);
          }
      );
    }
    /// 查询本地数据库是否存在该对话
    DBUtil.countRecords(userId: friend.userId,tabName: Tables.friendTab).then((value){
      int indexWhere=friendList.indexWhere((element) => element.userId==friend.userId);
      if(value!=null&&value<1&&indexWhere==-1){
        friendList.add(friend);
        update();
        DBUtil.insertRecord(json: friend.toJson()).then((value){
          if(value!=null&&value>0&&messagePrompt){
            Future.delayed(const Duration(milliseconds: 200),(){
              getConversationsRecord();
            });
          }
        });
      }else if(indexWhere!=-1){
        friendList[indexWhere].message=friend.message;
        friendList[indexWhere].sentTime=friend.sentTime;
        friendList[indexWhere].receivedTime=friend.receivedTime;
        friendList[indexWhere].unreadCount=(friendList[indexWhere].unreadCount??0)+1;
        friendList[indexWhere].messageType= friend.messageType;
        update();
        DBUtil.updateRecord([
          friendList[indexWhere].unreadCount,
          message.sentTime,
          message.receivedTime,
          friend.messageType,
          '${message.toJson()['text']}',
          friend.nickname,
          friend.portrait,
          friend.alias,
          friend.extra,
          0,
         friend.userId
        ]).then((value){
          debugPrint("更新结果$value");
        });
      }else if(indexWhere==-1){
        DBUtil.updateRecord([
          friend.unreadCount,
          friend.sentTime,
          friend.receivedTime,
          friend.messageType,
          friend.message,
          friend.nickname,
          friend.portrait,
          friend.alias,
          friend.extra,
          0,
         friend.userId,
        ]).then((value){
          friendList.add(friend);
          update();
          if(value!=null&&value>0&&messagePrompt){
            Future.delayed(const Duration(milliseconds: 200),(){
              getConversationsRecord();
            });
          }
        });
      }
    });
    insertChatRecord(args: args);
  }


  /// 启动App时加载新消息
  loopChatRecord(List<RCIMIWMessage>? list){
    if(list!=null&&list.isNotEmpty){
      for(RCIMIWMessage message in list){
        insertChatRecordTmp(message: message);
      }
    }
  }
  /// 启动App时加载新消息 插入新增信息
  insertChatRecordTmp({required RCIMIWMessage message}){
    Map<String,dynamic>? map;
    switch(message.messageType){
      case RCIMIWMessageType.text:
        map= {
          "senderId": jsonDecode(message.extra!)['angleUserId'],
          "senderUid": message.senderUserId,
          "senderAppId": jsonDecode(message.extra!)['angleAppId'],
          "receiveId": "${Constants.loginData!.userInfo!.userId}",
          "receiveUid": Constants.loginData!.userInfo!.id,
          "senderHeadImg": '${message.userInfo!.toJson()['portrait']}',
          "senderNickName": '${message.userInfo!.toJson()['name']}',
          "messageId": message.messageId,
          "messageType": 0,	/// 消息类型 0文本 1图片 2语音
          "unRead": 1, /// 0 已读 1未读
          "extra": '${message.userInfo!.toJson()['extra']}',
          "content": message.toJson()['text'].toString(),
          "sentTime": message.sentTime
        };
        break;
      case RCIMIWMessageType.image:
        break;
      case RCIMIWMessageType.voice:
        break;
      default:
        debugPrint("未匹配到消息类型");
    }
      String sql='SELECT COUNT(*) FROM ${Tables.chatRecord} WHERE messageId=?';
      OperateDBUtil.countRecord(sql: sql,arguments: [message.messageId]).then((count){
        if(!(count!=null&&count>0)){
          if(map!=null){
            OperateDBUtil.insertRecord(json: map);
          }
        }
      });
  }
  /// 在App内活动 加载新消息 插入新增信息2
  insertChatRecord({required Map<String,dynamic> args,bool unRead=false}){
    Map<String,dynamic>? map;
    RCIMIWMessage message=args['message'];
    switch(message.messageType){
      case RCIMIWMessageType.text:
        map= {
          "senderId": jsonDecode(message.extra!)['angleUserId'],
          "senderUid": message.senderUserId,
          "senderAppId": jsonDecode(message.extra!)['angleAppId'],
          "receiveId": "${Constants.loginData!.userInfo!.userId}",
          "receiveUid": Constants.loginData!.userInfo!.id,
          "senderHeadImg": '${message.userInfo!.toJson()['portrait']}',
          "senderNickName": '${message.userInfo!.toJson()['name']}',
          "messageId": message.messageId,
          "messageType": 0,	/// 消息类型 0文本 1图片 2语音
          "unRead": unRead?0:1, /// 0 已读 1未读
          "extra": '${message.userInfo!.toJson()['extra']}',
          "content": message.toJson()['text'].toString(),
          "sentTime": message.sentTime
        };
        break;
      case RCIMIWMessageType.image:
        break;
      case RCIMIWMessageType.voice:
        break;
      default:
        debugPrint("未匹配到消息类型");
    }
    if(map!=null){
      args['message']=ChatMessageEntity.fromJson(map);
      Constants.eventBus.send('newMessage_${message.targetId}',args);
      OperateDBUtil.insertRecord(json: map);
    }
  }
}