import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_part_util.dart';
import 'package:flutter_d0601/utils/db_util.dart';
import 'package:flutter_d0601/utils/operate_db_util.dart';
import 'package:get/get.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import '../http/dio_service.dart';
import '../page/home/discover/model/chat_message_entity.dart';
import '../page/home/sed/model/query_seek_angle_info_entity.dart';
import '../page/home/sed/model/query_seek_likes_visitors_entity.dart';
import '../utils/media_util.dart';
import 'discover_controller.dart';


// class ChatMessage{
//   /// 我的uid_聊天对象uid 作为条件从本地数据库数据
//   String? id;
//   /// 发送者的融云id
//   String? uid;
//   /// 发送者头像
//   String? headImg;
//   /// 用户昵称
//   String? nickName;
//   /// 额外字段
//   String? extra;
//   /// 消息内容
//   String? content;
//   /// 消息id
//   String? messageId;
//   /// 消息类型 0文本 1图片 2语音
//   String? messageType;
//   /// 消息是否已读
//   bool? unRead;
// }

class ChatMessageController extends GetxController{
  OverlayEntry? overlayEntry;
  final TextEditingController contentEditingController=TextEditingController();
  final FocusNode contentFocusNode=FocusNode();
  final ScrollController? scrollController=ScrollController();
  final discoverController=Get.find<DiscoverController>();
  List emoteList=[];
  int bottomType=-1;
  bool showBottom=false;
  bool autoFocus=false;
  List<String> recordingTips=['Slide up to cancel','Release to cancel','Recording time is too short'];

  QuerySeekLikesVisitorsItems querySeekLikesVisitorsItems=QuerySeekLikesVisitorsItems();
  bool typing=false;

  List<ChatMessageEntity?> customMessageList=[];

  // List<RCIMIWMessage> messageList=[];


  removeEvent(String targetId){
    /// 本控制器中的discoverController已伴随页面被销毁 需要重新获取
    final discoverController=Get.find<DiscoverController>();
    /// 防止遗漏本地有而融云数没有的记录
    int indexWhere=discoverController.friendList.indexWhere((element) => element.targetId==targetId);
    if(indexWhere!=-1){
      discoverController.friendList[indexWhere].unreadCount=0;
      // DBUtil.updateRecordByTargetId([0,targetId]);
    }
    /// 清零相应对话的未读消息
    discoverController.getClearUnreadCount(targetId: targetId,
        onSuccess: (code){
          DBUtil.updateRecordByTargetId([0,targetId]);
          debugPrint("清空聊天未读消息--targetId $code");
        });
  }

  String? targetId;
  @override
  void onInit(){
    super.onInit();
    emoteList=EmoteUtil.emoteList;
    if(Get.parameters['userId']!=null){
      targetId=Get.parameters['targetId'];
      querySeekLikesVisitorsItems.uid=int.tryParse(targetId.toString());
      querySeekLikesVisitorsItems.userId=Get.parameters['userId'].toString();
      querySeekAngleInfo(targetUserId: Get.parameters['userId'].toString(),targetAppId: Get.parameters['appId'].toString());
    }else{
      querySeekLikesVisitorsItems=Get.arguments;
      targetId=querySeekLikesVisitorsItems.uid.toString();
    }
    Constants.eventBus.on('newMessage_$targetId', (args) { newMessage(args); });
    getHistoryMessageData();
  }


  /// 查询主播个人主页信息
  querySeekAngleInfo({required String targetAppId,required String targetUserId})async{
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//本人应用id
      'userId':Constants.loginData!.userInfo!.userId,//本人用户长id
      'targetAppId':targetAppId,//所要查询对象的appId
      'targetUserId':targetUserId,//所要查询对象的userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QuerySeekAngleInfoEntity querySeekAngleInfoEntity=await DioService<QuerySeekAngleInfoEntity>().querySeekAngleInfo(data);
    if(querySeekAngleInfoEntity.success??false){
      querySeekLikesVisitorsItems=QuerySeekLikesVisitorsItems.fromJson((querySeekAngleInfoEntity.data??QuerySeekAngleInfoData()).toJson());
      update();
    }
  }
  /// 来新消息了
  newMessage(Map<String,dynamic> args){
    // messageList.insert(0,args['message']);
    if(args['isSelf']!=null&&(!args['isSelf'])){
      typing=true;
      update();
      Timer(const Duration(seconds: 3),(){
        Future.delayed(const Duration(milliseconds: 300),(){
          customMessageList.insert(0, args['message']);
          typing=false;
          setListMax();
          update();
        });
      });
    }else{
      customMessageList.insert(0, args['message']);
      setListMax();
      update();
    }


  }

  /// 消息自定义格式化
  // ChatMessageEntity messageFormatting({required RCIMIWMessage message}){
  //   Map<String,dynamic> map={
  //     'userId':message.senderUserId!=querySeekLikesVisitorsItems.uid.toString()?Constants.loginData!.userInfo!.userId:querySeekLikesVisitorsItems.userId,
  //     'uid':message.senderUserId,
  //     'headImg': message.userInfo!.portrait,
  //     'nickName': message.userInfo!.name,
  //     'extra':message.userInfo!.extra,
  //     'content': '${message.toJson()['text']}',
  //     'messageId': message.targetId,
  //     'messageType': message.messageType,
  //     'sentTime':message.sentTime,
  //     'unRead': false,
  //   };
  //   return JsonConvert<ChatMessageEntity>().fromJson(map);
  // }

  double lastOffset=0;
  getHistoryMessageData({bool load=false,int pageSize=16})async{
    String sql='SELECT * FROM ${Tables.chatRecord} WHERE (senderUid=? AND receiveUid=?) OR (senderUid=? AND receiveUid=?) order by sentTime desc LIMIT ?,?';
    List<ChatMessageEntity?> cMessageList = await OperateDBUtil<ChatMessageEntity>().selectRecord(sql: sql,
        arguments: [Constants.loginData!.userInfo!.id.toString(),targetId.toString()
          ,targetId.toString(),Constants.loginData!.userInfo!.id.toString(),customMessageList.length,customMessageList.length+pageSize]);
    customMessageList.addAll(cMessageList);
    debugPrint('获取到本地数据--${cMessageList.length}--${customMessageList.length}');
    // await discoverController.getHistoryMessage(
    //  pageSize: 20,
    //    sentTime: messageList.length>1?messageList[messageList.length-1].sentTime!:DateTime.now().millisecondsSinceEpoch,
    //    targetId: querySeekLikesVisitorsItems.uid.toString(),onSuccess:(list){
    //  if(load){
    //    messageList.addAll(list??[]);
    //  }else{
    //    messageList=list??[];
    //  }
    //  update();
    // }, onError: (int? code) {
    //   debugPrint('消息加载异常$code');
    // });
  }

  /// 更新聊天消息
  // updateChatMessage(List<RCIMIWMessage> messages,{bool unRead=true}){
  //   for(int index=0;index<messages.length;index++){
  //     Map messageMap = messages[index].toJson();
  //     Map<String,dynamic> chatMap={
  //       "id": '${Constants.loginData!.userInfo!.id}_${querySeekLikesVisitorsItems.uid}',
  //       "uid": "${messageMap['targetId']}",
  //       "headImg": querySeekLikesVisitorsItems.headImg,
  //       "nickName": querySeekLikesVisitorsItems.nickname,
  //       "extra": "",
  //       "messageId": messageMap['messageId'],
  //       "messageType": messageMap['messageType'],
  //       "sentTime": messageMap['sentTime'],
  //       "unRead": unRead
  //     };
  //     if(messageMap['messageType']==2){
  //       chatMap['content']=messageMap['text'];
  //     }
  //     messageList.add(JsonConvert<ChatMessageEntity>().fromJson(chatMap));
  //   }
  //   update();
  // }
  // List<String> historyContent=[
  //   'Hi, can we chat?',
  // 'Your smile attracts me.',
  // 'I like your style',
  // 'Do we share interests',
  // 'Share some fun stories',
  //   'We seem to have common.'
  // ];



  /// 发送文本消息
  sendTextMessage({RCIMIWMessageType messageType=RCIMIWMessageType.text}){
    String sendText=contentEditingController.text.toString();
    contentEditingController.clear();
    // Map<String,dynamic> messageMap={'offLine': false, 'targetId': querySeekLikesVisitorsItems.uid.toString(),
    //   'senderUserId': Constants.loginData!.userInfo!.id.toString(), 'messageId': 0, 'groupReadReceiptInfo': {'respondUserIds': {},
    //     'hasRespond': false, 'readReceiptMessage': false}, 'sentStatus': 2,
    //   'conversationType': 1, 'messageUId': '',
    //   'pushOptions': {'pushTitle': null, 'voIPPush': false, 'pushData': null,
    //     'forceShowDetailContent': false, 'pushContent': null, 'templateId': null,
    //     'disableNotification': false, 'disablePushTitle': false}, 'messageType': 2,
    //   'receivedStatus': 1,
    //   'receivedTime': DateTime.now().millisecondsSinceEpoch, 'extra': null, 'sentTime': DateTime.now().millisecondsSinceEpoch,
    //   'text': sendText, 'channelId': '', 'direction': 0};
    //
    // Constants.eventBus.send('newMessage_${querySeekLikesVisitorsItems.uid.toString()}',{
    // 'message':RCIMIWTextMessage.fromJson(messageMap),
    // 'left':false,
    // 'offline':true,
    // 'hasPackage':false,
    // 'isSelf':true,
    // });
    Map<String,dynamic> map= {
      "senderId": "${Constants.loginData!.userInfo!.userId}",
      "senderUid": "${Constants.loginData!.userInfo!.id}",
      "senderAppId": "${Constants.loginData!.userInfo!.appId}",
      "receiveId": "${querySeekLikesVisitorsItems.userId}",
      "receiveUid": "${querySeekLikesVisitorsItems.uid}",
      "messageId": -1,
      "messageType": 0,	/// 消息类型 0文本 1图片 2语音
      "unRead": 0, /// 0 已读 1未读
      "senderHeadImg": '${Constants.loginData!.userInfo!.headImg}',
      "senderNickName": '${Constants.loginData!.userInfo!.nickname}',
      "extra": "",
      "content": sendText,
      "sentTime": DateTime.now().millisecondsSinceEpoch
    };
    switch(messageType){
      case RCIMIWMessageType.text:
        map['messageType']=0;
        break;
      case RCIMIWMessageType.image:
        map['messageType']=1;
        break;
      case RCIMIWMessageType.voice:
        map['messageType']=2;
        break;
      default:
        debugPrint("未匹配到消息类型");
    }
    // customMessageList.add(ChatMessageEntity.fromJson(map));
    Constants.eventBus.send('newMessage_${querySeekLikesVisitorsItems.uid.toString()}',{
      'message':ChatMessageEntity.fromJson(map),
      'left':false,
      'offline':true,
      'hasPackage':false,
      'isSelf':true,
    });
    update();
    discoverController.sendTextMessage(
        robotUid: querySeekLikesVisitorsItems.uid.toString(),
        message: sendText,
        failure: (){
          contentEditingController.text=sendText;
          contentEditingController.selection =TextSelection.fromPosition(TextPosition(offset:sendText.length));
          int indexWhere=customMessageList.indexWhere((element) => element?.messageId==-1&&element?.content==sendText);
          if(indexWhere!=-1){
            customMessageList.removeAt(indexWhere);
          }
          update();
        },
        ///RCIMIWMessage message
        onSuccess: (){
          // {"conversationType":1,"messageType":2,"targetId":"28843259","channelId":null,"messageId":0,
          // "messageUId":null,"offLine":false,"groupReadReceiptInfo":null,"receivedTime":0,"sentTime":0,"receivedStatus":0,"sentStatus":0,
          // "senderUserId":null,"direction":0,"userInfo":null,"mentionedInfo":null,"pushOptions":null,"extra":null,"expansion":null,"text":"😉😉"}
          // message.sentTime=DateTime.now().millisecondsSinceEpoch;

          // {"conversationType":1,"messageType":2,"targetId":"28843158","channelId":null,"messageId":8,
          // "messageUId":"CAO3-20T5-L9I5-NK23","offLine":false,"groupReadReceiptInfo":null,"receivedTime":0,
          // "sentTime":1695451188886,"receivedStatus":0,"sentStatus":2,"senderUserId":"28844281",
          // "direction":0,"userInfo":null,"mentionedInfo":null,"pushOptions":null,"extra":null,"expansion":null,"text":"Your smile attracts me."}

          // map['messageId']=message.messageId;
          // map['sentTime']=message.sentTime;
          map['messageId']=-2;
          int indexWhere=customMessageList.indexWhere((element) => element?.messageId==-1&&element?.content==sendText);
          if(indexWhere!=-1){
            customMessageList[indexWhere]=ChatMessageEntity.fromJson(map);
          }
          OperateDBUtil.insertRecord(json: map,tableName: Tables.chatRecord);
          // Constants.eventBus.send('newMessage_${querySeekLikesVisitorsItems.uid.toString()}',{
          //   'message':ChatMessageEntity.fromJson(map),
          //   'left':false,
          //   'offline':true,
          //   'hasPackage':false,
          //   'isSelf':true,
          // });
          discoverController.recordChatUser(querySeekLikesVisitorsItems.uid.toString());
          insertMyConversation(sendMessage: sendText,messageType: 0);
          setListMax();
          update();
    });

  }
  /// 插入新对话或更新对话
  insertMyConversation({required String sendMessage,required int messageType}){
    DBUtil.countRecords(userId: querySeekLikesVisitorsItems.userId!,tabName: Tables.friendTab).then((value){
      if(value!=null&&value<1){
        Map<String,dynamic> map={
          "landerUID": Constants.loginData!.userInfo!.id.toString(),
          "message": sendMessage,
          "targetId": querySeekLikesVisitorsItems.uid.toString(),
          "appId": querySeekLikesVisitorsItems.appId.toString(),
          "messageType":messageType,
          "conversationType": 1,
          "userId":querySeekLikesVisitorsItems.userId,
          "nickname": querySeekLikesVisitorsItems.nickname,
          "portrait": querySeekLikesVisitorsItems.headImg,
          "alias": querySeekLikesVisitorsItems.description,
          "extra": "",
          "receivedTime": DateTime.now().millisecondsSinceEpoch,
          "sentTime": DateTime.now().millisecondsSinceEpoch,
          "unreadCount": 0,
          "offLine": querySeekLikesVisitorsItems.onlineStatus??1,
          "top": 0
        };
        DBUtil.insertRecord(json: map).then((value){
          if(value!=null&&value>0){
            Future.delayed(const Duration(milliseconds: 200),(){
              Get.find<DiscoverController>().getConversationsRecord();
            });
          }
        });
      }else{
        if(customMessageList.isNotEmpty){
          DBUtil.updateRecord([
            0,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
            messageType,
            sendMessage,
            querySeekLikesVisitorsItems.nickname.toString(),
            querySeekLikesVisitorsItems.headImg.toString(),
            "",
            "",
            0,
            querySeekLikesVisitorsItems.userId.toString()
          ]);
          //     .then((value){
          //   if(value!=null&&value>0){
          //     Future.delayed(const Duration(milliseconds: 200),(){
          //       Get.find<DiscoverController>().getConversationsRecord();
          //     });
          //   }
          // });
        }
      }
    });
  }

  /// 选择自定义内容 表情 历史记录
  chooseContent(String con){
    if(contentEditingController.selection.baseOffset>-1){
      String content=contentEditingController.text.toString().substring(0,contentEditingController.selection.baseOffset);
      contentEditingController.text=contentEditingController.text.toString().replaceFirst(content, content+con);
      contentEditingController.selection =TextSelection.fromPosition(TextPosition(offset:(content+con).toString().length));
    }else{
      contentEditingController.text+=con;
      contentEditingController.selection =TextSelection.fromPosition(TextPosition(offset:(contentEditingController.text.toString().length)));
    }
    update();
  }

  ///是否正在录音
  bool recording=false;
  /// 录音状态 0:开始录音 1:取消录音 2：结束录音
  int recordStatus=-1;
  /// 录音时间
  int recordTime=0;
  /// 录音计时事件
  Timer? recordTimer;
  /// 开始与结束录音 status 0:开始录音 1:取消录音 2：结束录音
  void startOrOverRecord({required int status}){
    switch(status){
      case 0:
        if(recordStatus==0)return ;
        recordStatus=status;
        recording=true;
        recordTimer?.cancel();
        recordTimer=null;
        recordTime=0;
        MediaUtil.startRecordAudio();
        recordTimer=Timer.periodic(const Duration(seconds: 1), (timer) {
          recordTime+=1;
          update();
        });
        break;
      case 1:
        if(recordStatus==1)return ;
        recordStatus=status;
        recording=false;
        recordTimer?.cancel();
        recordTimer=null;
        MediaUtil.stopRecordAudio(delete: true);
        recordTimer=Timer(const Duration(seconds: 3), (){
          recordStatus=-1;
          update();
        });
        break;
      case 2:
        if(recordStatus==1||recordStatus==2)return ;
        recordStatus=status;
        recording=false;
        recordTimer?.cancel();
        recordTimer=null;
        if(recordTime<=3){
          MediaUtil.stopRecordAudio(delete: true);
          recordTimer=Timer(const Duration(seconds: 3), (){
            recordStatus=-1;
            update();
          });
        }else{
          MediaUtil.stopRecordAudio(delete: false);
          recordStatus=-1;
        }
        break;
    }
    update();
  }

  /// listView滑动到指定位置
  void setListMax() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(milliseconds: 300), () {
        if(scrollController!=null){
          try{
            double lastOffset = scrollController!.position.minScrollExtent;
            scrollController!.jumpTo(lastOffset);
          }catch(e){
            debugPrint("聊天列表滑到底部异常$e");
          }
        }
      });
      update();
    });
  }

  /// 失去焦点
  lossOfFocus({int type=-1,bool body=false}){
    // print('b=$bottomType t=$type b=$body');
    if(bottomType==2&&type==2){
      contentFocusNode.requestFocus();
      if(contentEditingController.selection.baseOffset>-1){
        contentEditingController.selection =TextSelection.fromPosition(TextPosition(offset:(contentEditingController.selection.baseOffset)));
      }
    }else{
      if(type!=-1){
        bottomType=type;
      }else if(bottomType==2){
        bottomType=type;
      }
      if(contentFocusNode.hasFocus){
        contentFocusNode.unfocus();
      }
      if(type==2){
        autoFocus=true;
      }
    }
    update();
  }
  disposeOverLayEntry(){
    if(overlayEntry!=null){
      overlayEntry!.remove();
      overlayEntry=null;
      update();
    }
  }
}