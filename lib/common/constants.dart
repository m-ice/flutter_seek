import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_d0601/controller/discover_controller.dart';
import 'package:flutter_d0601/utils/event_bus.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';
import '../controller/phone_login_controller.dart';
import '../enum/cache_data_enum.dart';
import '../page/login/model/login_entity.dart';
import '../page/router/router_manager.dart';
import '../utils/app_package_info_util.dart';
import '../utils/toast_util.dart';



///存放app常量
class Constants{
  /// app名称
  static const String appTitle="Seek";

  /// 融云的key
  static const String rCloudImKey="0vnjpoad0iitz";

  /// 腾讯FlutterBugly
  static const String bugAndroidAppId='adbb75d755';
  static const String bugIOSAppId='e4bae90335';

  /// 用户协议
  static const String userAgreement='https://video.seekivideo.com/protocols/v1/agreement.html';
  /// 隐私协议
  static const String privacyAgreement='https://video.seekivideo.com/protocols/v1/privacy.html';


  // static Map<String, dynamic> headers={};
  //
  // /// 生成请求头
  // static Future<bool> getRequestHeaders({required String requestType,
  //   required String method,required String module,Map<String, dynamic>? params,dynamic data})async{
  //   /// 登录信息
  //   LoginData? loginData=CacheUserDataUtil.getCacheLoginData(CacheKey.loginData);
  //   int timestamp=0;
  //   try{
  //     timestamp=DateTime.now().millisecondsSinceEpoch;
  //   }catch(e){
  //     LogUtil.logUtil(e.toString());
  //   }
  //   headers = {
  //     "Content-Type": "application/json",
  //     "module": module,
  //     "appId": "v.u.$method",
  //     "appVersion": 1,
  //     "method": method,
  //     "appKey": "vivalive-qa",
  //     "timestamp": timestamp,
  //     // "publicKey": "3e3dcf27c0de",
  //     "rpcType": "dubbo",
  //   };
  // headers['sign']= MD5Util.generateMd5("content${data}method${method}module"
  //       "${module}rpcTypedubbotimestamp${timestamp}vivalive-qa");
  //
  // return true;
  // }


  /// 支持的国家列表
  static List<Country> countryList=[
    Country(countryName: 'United States', headPhoneNumber: '1', iconName: 'United States',countryCode: 'US'),
    Country(countryName: 'Canada', headPhoneNumber: '1', iconName: 'Canada',countryCode: 'CA'),
    Country(countryName: 'United Kingdom', headPhoneNumber: '44', iconName: 'United Kingdom',countryCode: 'GB'),
    Country(countryName: 'Australia', headPhoneNumber: '61', iconName: 'Australia',countryCode: 'AU'),
    Country(countryName: 'New Zealand', headPhoneNumber: '64', iconName: 'New Zealand',countryCode: 'NZ')
  ];
  /// 登录的用户数据
  static LoginData? loginData;
  /// 登录所选择的国家
  static Country? country;
  /// 纬度
  static double? latitude;
  /// 经度
  static double? longitude;
  /// 消息总数
  static int messageCount=0;
  static int blockDataMessageCount=0;

  /// 是否是为vip
  static bool isOpenMembership=false;
  /// 是否是为审核账号或审核版本
  static bool isAuditOrNot=false;

  /// 记录Likes you
  static List<String> circleDataListZero=[];
  /// 记录Visitors
  static List<String> circleDataListOne=[];
  /// 已经聊天的数据 uid
  static List<String> alreadyChatDataList=[];
  /// 已经匹配过的数据 userId
  static List<String> alreadyMatchDataList=[];
  /// 拉黑的数据 userId
  static List<String> blockDataList=[];



  // static List<OtherData> otherList=[];

  static  EventBus eventBus=EventBus();

  static String appId='28cb238c-1f8f-44e8-b41d-3e3dcf27c0de';

  /// 退出登录
  static commonLogOut({bool showTips=false}){
    CustomCacheUtil.remove(CacheDataEnum.loginData.toString())!.then((value){
      if(value){
        // DBUtil.closeDataBase();
        try{
          Get.find<DiscoverController>().disconnect();
          Get.find<DiscoverController>().destroy();
        }catch(e){
          e.printError();
        }
        BotToast.cleanAll();
        messageCount=0;
        blockDataMessageCount=0;
        loginData=null;
        if(showTips){
          toast('network error');
        }
        Get.offAllNamed(RouterManager.login);
      }
    });
  }

  /// 对话时间
  static String sessionTime({required int millisecond}){
    DateTime sessionTime=DateTime.fromMillisecondsSinceEpoch(millisecond);
    DateTime now=DateTime.now();
    if(sessionTime.year==now.year){
      if(sessionTime.month==now.month){
        if(sessionTime.day==now.day){
          // return 'today';
          return sessionTime.toString().substring(11,19);
        }else if(now.day-sessionTime.day==1){
          return 'yesterday';
        }
      }
    }
    return sessionTime.toString().substring(0,19);
  }
  /// 对话时间
  static String? chatMessageTime({required int currentMillisecond, int? nextMillisecond}){

    DateTime currentChatTime=DateTime.fromMillisecondsSinceEpoch(currentMillisecond);
    DateTime nowMillisecond=DateTime.now();
    nextMillisecond ??=nowMillisecond.millisecondsSinceEpoch;

    int millisecond=currentMillisecond-nextMillisecond;
    if(Duration(milliseconds: millisecond>0?millisecond:(millisecond*-1))>const Duration(minutes: 5)){
      if(Duration(milliseconds: nowMillisecond.millisecondsSinceEpoch-currentMillisecond)<const Duration(days: 1)&&
      nowMillisecond.day==currentChatTime.day){
        return currentChatTime.toString().substring(11,19);
      }else{
        // if(nowMillisecond.year==currentChatTime.year){
        //   if(nowMillisecond.month==currentChatTime.month){
        //     if(nowMillisecond.day-currentChatTime.day==1){
        //       return 'yesterday ${currentChatTime.toString().substring(11,19)}';
        //     }
        //   }
        // }
        return currentChatTime.toString().substring(0,19);
      }
    }
    return null;
  }
  /// 获取请求参数
  static Map<String,dynamic> getRequestParameter({required Map<String,dynamic> business, int productId=301}){

    //国家码，ISO 3166-1对应的两位大写
    business['countryCode']??=Constants.country!=null?Constants.country!.countryCode:'US';
    // 设备号
    business['device']??=AppPackageInfoUtil.deviceId;
    //签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
    business['sign']??=MD5Util.generateMd5("${appId}7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn");
    //用户appId
    business['appId']??=Constants.loginData!=null?Constants.loginData!.userInfo!.appId??appId:appId;
    //客户端版本号
    business['appKey']??=AppPackageInfoUtil.appKey;
    //产品id，301
    business['productId']=productId;
    dynamic data = {
      "baseParams":{
        'appId': Constants.loginData!=null?Constants.loginData!.userInfo!.appId??appId:appId, //用户appId
        'appKey': AppPackageInfoUtil.appKey, //客户端版本号
        'device': AppPackageInfoUtil.deviceId,
        'lang': 'en', //语言缩写
      },
      'business':business,
      'userAuth':{
        'appId':Constants.loginData!=null?Constants.loginData!.userInfo!.appId??appId:appId, //用户appId
        'device':AppPackageInfoUtil.deviceId,
        'token': loginData!=null?loginData!.token:null,
        'userId': loginData!=null?loginData!.userInfo!.userId:null,
        'lang':'en', //语言缩写
        'lat':latitude.toString(),
        'lon':longitude.toString(),
        'region':''
      }
    };
    return data;
  }
}