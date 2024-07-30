import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/circle_controller.dart';
import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../utils/app_package_info_util.dart';
import 'discover_controller.dart';
import 'home_controller.dart';



// class ConversationContent{
//   /// 最后一条消息内容
//   String? message;
//   /// 对话id
//   String? targetId;
//   // /// 消息id
//   // String? messageId;
//   // /// 消息uid
//   // String? messageUId;
//   /// 消息类型
//   int? messageType;
//   /// 对话类型
//   int? conversationType;
//   /// 用户 id。
//   String? userId;
//   /// 名称（昵称）。
//   String? name;
//   /// 用户头像地址。
//   String? portrait;
//   /// 备注
//   String? alias;
//   /// 附加信息。
//   String? extra;
//   /// 接收时间
//   int? receivedTime;
//   /// 发送时间
//   int? sentTime;
//   /// 未读消息数
//   int? unreadCount;
//   /// 是否在线
//   int? offLine;
//   /// 是否置顶
//   bool? top;
//   ConversationContent({
//     this.conversationType,
//     this.messageType,
//     this.message,
//     this.userId,
//     this.name,
//     this.extra,
//     this.top,
//     this.alias,
//     this.offLine,
//     this.portrait,
//     this.receivedTime,
//     this.sentTime,
//     this.targetId,
//     this.unreadCount
// });
// }

class CustomPayMentMessage extends RCIMIWUserCustomMessage{
  CustomPayMentMessage(super.type, super.targetId);

  @override
  void decode(String jsonStr) {
    // TODO: implement decode
  }

  @override
  String encode() {
    // TODO: implement encode
    throw UnimplementedError();
  }

  @override
  String messageObjectName() {
    // TODO: implement messageObjectName
    throw UnimplementedError();
  }

  static fromJson(Map<String, dynamic> map) {}

}

class RCloudImBaseController extends GetxController{

  final String tag='【${Constants.appTitle}-rCloud】';
  RCIMIWEngineOptions? options;
  RCIMIWEngine? engine;
  String imToken='';
  /// 融云连接状态
  RCIMIWConnectionStatus? rcImConnectionStatus;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initSdk();
  }
  /// 初始化融云sdk
  initSdk()async{
    // kickReconnectDevice
    // 设置为 true：
    // 如果重连时发现已有别的移动端设备在线，将不再重连，不影响已正常登录的移动端设备。
    // 设置为 false：
    // 如果重连时发现已有别的移动端设备在线，将踢出已在线的移动端设备，使当前设备上线。
    if(rcImConnectionStatus==RCIMIWConnectionStatus.networkUnavailable) return;
     options = RCIMIWEngineOptions.create(
       kickReconnectDevice: false,
       naviServer: "nav.sg-light-edge.com",
       statisticServer: "stats.sg-light-edge.com",
     );
     engine = await RCIMIWEngine.create(Constants.rCloudImKey, options!);
     addImUser();
     update();
  }

  /// 添加融云用户 获取融云token
  addImUser()async{
    Map<String,dynamic> business={
      "userId":Constants.loginData!.userInfo!.userId,
      "nickName":Constants.loginData!.userInfo!.nickname??'',
      "headImg":Constants.loginData!.userInfo!.headImg??'',
      "appKey":AppPackageInfoUtil.appKey,
      "appId":"28cb238c-1f8f-44e8-b41d-3e3dcf27c0de",
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    BaseEntity  baseEntity =await DioService<BaseEntity>().addImUser(data);
    if(baseEntity.success??false){
      imToken=baseEntity.data['imToken'];
      connectRCloud(imToken, 3);
      update();
    }
  }

  /// 连接融云
  connectRCloud(String token,int timeout)async{
    disconnect().then((value){
      /// 监听连接状态
      engine?.onConnectionStatusChanged = (RCIMIWConnectionStatus? status) {
        LogUtil.logInfo('连接融云的状态onConnectionStatusChanged：$status');
        rcImConnectionStatus=status;
        if(status==RCIMIWConnectionStatus.kickedOfflineByOtherClient){
          Constants.commonLogOut();
        }
        // if(status==RCIMIWConnectionStatus.connected){
        //   // getConversations();
        // }
        update();
      };
    });

    RCIMIWConnectCallback? callback = RCIMIWConnectCallback(
      /// 打开数据库
        onDatabaseOpened: (int? code) {
      LogUtil.logInfo('连接融云的状态onDatabaseOpened：$code');
    }, onConnected: (int? code, String? userId) {
      LogUtil.logInfo('连接融云的状态onConnected：code=$code  userId=$userId');
    });
    /// 0: 连接成功
    int? ret = await engine?.connect(token, timeout, callback:callback);
    if(ret==0){
      listenMessageReceived();
    }
    LogUtil.logInfo('连接融云的状态：$ret');
  }

  /// 监听接收消息
  listenMessageReceived(){
    // 1.message 接收到的消息对象
    // 2.left 当客户端连接成功后，服务端会将所有补偿消息以消息包的形式下发给客户端，最多每 200 条消息为一个消息包，即一个
    // Package, 客户端接受到消息包后，会逐条解析并通知应用。left 为当前消息包（Package）里还剩余的消息条数
    // 3.offline 消息是否离线消息
    // 4.hasPackage 是否在服务端还存在未下发的消息包
    Map<String, dynamic> map={'offline': false, 'hasPackage': false, 'left': 0, 'message': {'offLine': false, 'targetId': 28843977,
      'senderUserId': 28843977, 'messageId': 0, 'rawData': null, 'groupReadReceiptInfo': {'respondUserIds': {},
        'hasRespond': false, 'readReceiptMessage': false}, 'sentStatus': 2, 'conversationType': 1,
      'messageUId': 'CB3N-COP8-1AI5-NRK8', 'pushOptions': {'pushTitle': null, 'voIPPush': false,
        'pushData': null, 'forceShowDetailContent': false, 'pushContent': null, 'templateId': null,
        'disableNotification': false, 'disablePushTitle': false}, 'messageType': 0, 'receivedStatus': 1,
      'receivedTime': 1697012877800, 'extra': null, 'objectName': 'app:PayMsg', 'sentTime': 1697012878496,
      'channelId': null, 'direction': 0}};
    engine?.registerCustomMessage('app:PayMsg', (json){
      return CustomPayMentMessage.fromJson(map);
    });
    engine?.onMessageReceived = (RCIMIWMessage? message, int? left, bool? offline, bool? hasPackage) {
      if(message!.toJson()['objectName'].toString()!="app:PayMsg"){
        Constants.eventBus.send('insertOrUpdateConversation',{
          'message':message,
          'left':left,
          'offline':offline,
          'hasPackage':hasPackage,
          'isSelf':false,
        });
      }else{
        Constants.eventBus.send('app:PayMsg',{
          'message':message,
          'left':left,
          'offline':offline,
          'hasPackage':hasPackage,
          'isSelf':false,
        });
      }

      // Constants.eventBus.send('newMessage_${message!.targetId}',{
      //   'message':message,
      //   'left':left,
      //   'offline':offline,
      //   'hasPackage':hasPackage,
      //   'isSelf':false,
      // });
      print("新消息体${message.extra}---${jsonDecode(message.extra!)}");
      LogUtil.logInfo('接收消息：message=${jsonEncode(message)} left=$left offline=$offline hasPackage=$hasPackage');
    };
  }


  List<RCIMIWConversation> conversation=[];
  /// 获取会话
  Future<List<RCIMIWConversation>> getConversations({List<RCIMIWConversationType>? conversationType,String? channelId,int? startTime,
  IRCIMIWGetConversationsCallback? callback,
    Function(List<RCIMIWConversation>?)? onSuccess,
  //   required Function(int?) onError,
  })async{
    startTime??=DateTime.now().millisecondsSinceEpoch;
    conversationType??=[RCIMIWConversationType.private,RCIMIWConversationType.system];
     callback ??= IRCIMIWGetConversationsCallback(onSuccess: (List<RCIMIWConversation>? t) {
       conversation=t??[];
       onSuccess?.call(t??[]);
      for(RCIMIWConversation c in conversation ){
        recordChatUser(c.lastMessage!.targetId.toString());
      }
      Get.find<CircleController>().update();
      Get.find<SedController>().update();
      update();
      LogUtil.logUtil('获取会话:${jsonEncode(t)}',tag: tag);
    }, onError: (int? code) {
      LogUtil.logUtil('获取会话:code=$code',tag: tag);
    });
    int? code = await engine?.getConversations(conversationType, channelId, startTime, 30, callback:callback);

    LogUtil.logInfo('获取会话状态码：$code');
    return conversation;
  }


  /// 记录聊过天的人
  recordChatUser(String uid){
    List<String> list=[];
    int indexWhere=Constants.alreadyChatDataList.indexWhere((element) => element==uid);
    if(indexWhere==-1){
      list.add(uid);
      list.addAll(CacheUserDataUtil.getStringListData("alreadyChatData_${Constants.loginData!.userInfo!.id}"));
      CustomCacheUtil.putStringList("alreadyChatData_${Constants.loginData!.userInfo!.id}", list);
      Constants.alreadyChatDataList=list;
    }
    update();
  }
  /// 发送消息
  sendMessage(RCIMIWMessage? message,RCIMIWSendMessageCallback callback){
    engine!.sendMessage(message!,callback: callback);
  }
    /// 获取本地历史消息
  Future getHistoryMessage({RCIMIWConversationType? conversationType,required int sentTime,required String targetId, String? channelId,
    int pageSize=16,required Function(List<RCIMIWMessage>?) onSuccess,required Function(int?) onError}) async {
    IRCIMIWGetMessagesCallback callback= IRCIMIWGetMessagesCallback(onSuccess: onSuccess, onError: onError);
    int code= await engine!.getMessages(
       conversationType??RCIMIWConversationType.private,
       targetId,
       channelId,
       sentTime,
       RCIMIWTimeOrder.before,
       RCIMIWMessageOperationPolicy.localRemote,
       pageSize,callback: callback,
    );
    LogUtil.logInfo("获取聊天记录状态码：code=$code");
  }
  /// 创建文本消息
  sendTextMessage({RCIMIWConversationType conversationType=RCIMIWConversationType.private,required String robotUid,
    String? channelId,required String message,Function? onSuccess,Function? failure})async{
    Map<String,dynamic> business={
      // 'parentId': ,//上级配置id
      // 'key':AppPackageInfoUtil.appKey,//配置key
      // 'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      'productId':301,//产品id，301
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'robotUid':robotUid,//主播uid
      'message':message,//文本内容
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    try{
      BaseEntity baseEntity=await DioService<BaseEntity>().aiTalk(data);
      if(baseEntity.success??false){
        onSuccess?.call();
        // RCIMIWTextMessage? textMessage = await engine?.createTextMessage(
        //   conversationType,
        //   robotUid,
        //   channelId,
        //   message.toString(),
        // );
        // // onSuccess?.call(textMessage);
        // RCIMIWSendMessageCallback callback=RCIMIWSendMessageCallback(
        //     onMessageSaved: (RCIMIWMessage? message) {
        //       LogUtil.logUtil('发送文本消息onMessageSaved:',tag: tag);
        //       // {"conversationType":1,"messageType":2,"targetId":"28843012","channelId":null,
        //       // "messageId":19,"messageUId":null,"offLine":false,"groupReadReceiptInfo":null,"receivedTime":0,
        //       // "sentTime":1693444660791,"receivedStatus":0,"sentStatus":0,"senderUserId":"28842896","direction":0,
        //       // "userInfo":null,"mentionedInfo":null,"pushOptions":null,"extra":null,"expansion":null,"text":"6666@@88855"}
        //       LogUtil.logInfo(jsonEncode(message));
        //     },
        //     onMessageSent: (int? code, RCIMIWMessage? message) {
        //       onSuccess?.call(message);
        //       // LogUtil.logUtil('发送文本消息onMessageSent:',tag: tag);
        //       // LogUtil.logInfo(jsonEncode(message));
        //
        //       // Constants.eventBus.send('newMessage_${message!.targetId}',{
        //       //   'message':message,
        //       //   'left':false,
        //       //   'offline':true,
        //       //   'hasPackage':false,
        //       //   'isSelf':true,
        //       // });
        //       // {"conversationType":1,"messageType":2,"targetId":"28843012","channelId":null,"messageId":19,
        //       // "messageUId":"CA94-LDUO-A7S5-NJ00","offLine":false,"groupReadReceiptInfo":null,"receivedTime":0,
        //       // "sentTime":1693444661089,"receivedStatus":0,"sentStatus":2,"senderUserId":"28842896","direction":0,
        //       // "userInfo":null,"mentionedInfo":null,"pushOptions":null,"extra":null,"expansion":null,"text":"6666@@88855"}
        //       LogUtil.logUtil('发送文本消息onMessageSent:',tag: tag);
        //       LogUtil.logInfo(jsonEncode(message));
        //     });
        // sendMessage(textMessage, callback);
      }else{
        failure?.call();
      }
    }catch(e){
      failure?.call();
    }

  }

  /// 会话未读数
  getTotalUnreadCount({String? channelId,required Function(int? t) onSuccess})async{
    IRCIMIWGetTotalUnreadCountCallback? callback = IRCIMIWGetTotalUnreadCountCallback(onSuccess: onSuccess, onError: (int? code) {
      LogUtil.logUtil('获取会话未读数异常：$code',tag: tag);
    });
    int? code = await engine?.getTotalUnreadCount(channelId, callback:callback);

    LogUtil.logInfo("获取聊天会话未读记录数状态码：code=$code");
  }

  /// 清除单聊未读消息
  getClearUnreadCount({RCIMIWConversationType conversationType=RCIMIWConversationType.private,
     String? channelId,
     int? timestamp,
    required String targetId,required Function(int? t) onSuccess})async{
    IRCIMIWClearUnreadCountCallback? callback = IRCIMIWClearUnreadCountCallback(onUnreadCountCleared: onSuccess);
    int? code = await engine?.clearUnreadCount(conversationType,targetId,channelId,timestamp??DateTime.now().millisecondsSinceEpoch,
        callback:callback);
    getTotalUnreadCount(onSuccess: (t){
      Constants.messageCount=t??0;
      Get.find<HomeController>().update();
      Get.find<DiscoverController>()..getConversationsRecord()..update();
    });
    LogUtil.logInfo("清除单聊未读消息状态码：code=$code");
  }

  /// 创建语音消息
  sendVoiceMessage()async{
    // RCIMIWVoiceMessage voiceMessage=await engine?.createVoiceMessage(type, targetId, channelId, path, duration);
  }
  /// 创建图片消息
  sendImageMessage({
    RCIMIWConversationType conversationType=RCIMIWConversationType.private,required String robotUid,
    String? channelId,required String path})async{
    RCIMIWImageMessage? imageMessage=await engine?.createImageMessage(conversationType, robotUid, channelId, path);
    RCIMIWSendMediaMessageListener listener=RCIMIWSendMediaMessageListener(
      onMediaMessageSaved: (RCIMIWMediaMessage? message){

      },
      onMediaMessageSent: (int? code,RCIMIWMediaMessage? message){

      },
      onMediaMessageSending: (RCIMIWMediaMessage? message, int? progress){
        debugPrint('发送进度条$progress');
      },
      onSendingMediaMessageCanceled: (RCIMIWMediaMessage? message){

      }
    );
    await engine?.sendMediaMessage(imageMessage!,listener: listener);
  }

  /// 发送文件消息
  sendMMessage()async{
    // RCIMIWFileMessage fileMessage=await engine?.createFileMessage(type, targetId, channelId, path);
  }

  /// 退出融云登录
  Future<int?> disconnect()async{
    int? ret = await engine?.disconnect(false);
    LogUtil.logUtil("断开融云连接:$ret",tag: tag);
    return ret;
  }

  /// 销毁融云引擎
  destroy()async{
    await engine?.destroy();
    LogUtil.logUtil("销毁融云引擎",tag: tag);
  }

}