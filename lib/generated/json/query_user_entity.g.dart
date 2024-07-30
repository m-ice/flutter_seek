import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/query_user_entity.dart';

QueryUserEntity $QueryUserEntityFromJson(Map<String, dynamic> json) {
  final QueryUserEntity queryUserEntity = QueryUserEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    queryUserEntity.code = code;
  }
  final QueryUserData? data = jsonConvert.convert<QueryUserData>(json['data']);
  if (data != null) {
    queryUserEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    queryUserEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    queryUserEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    queryUserEntity.message = message;
  }
  return queryUserEntity;
}

Map<String, dynamic> $QueryUserEntityToJson(QueryUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension QueryUserEntityExtension on QueryUserEntity {
  QueryUserEntity copyWith({
    int? code,
    QueryUserData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return QueryUserEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

QueryUserData $QueryUserDataFromJson(Map<String, dynamic> json) {
  final QueryUserData queryUserData = QueryUserData();
  final int? charmLevel = jsonConvert.convert<int>(json['charmLevel']);
  if (charmLevel != null) {
    queryUserData.charmLevel = charmLevel;
  }
  final int? channel = jsonConvert.convert<int>(json['channel']);
  if (channel != null) {
    queryUserData.channel = channel;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    queryUserData.source = source;
  }
  final int? cityId = jsonConvert.convert<int>(json['cityId']);
  if (cityId != null) {
    queryUserData.cityId = cityId;
  }
  final bool? empty = jsonConvert.convert<bool>(json['empty']);
  if (empty != null) {
    queryUserData.empty = empty;
  }
  final String? vsId = jsonConvert.convert<String>(json['vsId']);
  if (vsId != null) {
    queryUserData.vsId = vsId;
  }
  final dynamic advertAaid = json['advertAaid'];
  if (advertAaid != null) {
    queryUserData.advertAaid = advertAaid;
  }
  final dynamic initBasicInfoBySystem = json['initBasicInfoBySystem'];
  if (initBasicInfoBySystem != null) {
    queryUserData.initBasicInfoBySystem = initBasicInfoBySystem;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    queryUserData.appId = appId;
  }
  final List<dynamic>? pris = (json['pris'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (pris != null) {
    queryUserData.pris = pris;
  }
  final dynamic appKey = json['appKey'];
  if (appKey != null) {
    queryUserData.appKey = appKey;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    queryUserData.id = id;
  }
  final double? lat = jsonConvert.convert<double>(json['lat']);
  if (lat != null) {
    queryUserData.lat = lat;
  }
  final String? area = jsonConvert.convert<String>(json['area']);
  if (area != null) {
    queryUserData.area = area;
  }
  final String? headImg = jsonConvert.convert<String>(json['headImg']);
  if (headImg != null) {
    queryUserData.headImg = headImg;
  }
  final double? lng = jsonConvert.convert<double>(json['lng']);
  if (lng != null) {
    queryUserData.lng = lng;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    queryUserData.productId = productId;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    queryUserData.level = level;
  }
  final dynamic invitation = json['invitation'];
  if (invitation != null) {
    queryUserData.invitation = invitation;
  }
  final String? extendInfo = jsonConvert.convert<String>(json['extendInfo']);
  if (extendInfo != null) {
    queryUserData.extendInfo = extendInfo;
  }
  final String? authInfo = jsonConvert.convert<String>(json['authInfo']);
  if (authInfo != null) {
    queryUserData.authInfo = authInfo;
  }
  final dynamic privatePhotoUrl = json['privatePhotoUrl'];
  if (privatePhotoUrl != null) {
    queryUserData.privatePhotoUrl = privatePhotoUrl;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    queryUserData.name = name;
  }
  final String? campaign = jsonConvert.convert<String>(json['campaign']);
  if (campaign != null) {
    queryUserData.campaign = campaign;
  }
  final dynamic abResult = json['abResult'];
  if (abResult != null) {
    queryUserData.abResult = abResult;
  }
  final int? displayId = jsonConvert.convert<int>(json['displayId']);
  if (displayId != null) {
    queryUserData.displayId = displayId;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    queryUserData.device = device;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    queryUserData.status = status;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    queryUserData.birthday = birthday;
  }
  final String? gmtLastLogin = jsonConvert.convert<String>(
      json['gmtLastLogin']);
  if (gmtLastLogin != null) {
    queryUserData.gmtLastLogin = gmtLastLogin;
  }
  final QueryUserDataFunctionAuth? functionAuth = jsonConvert.convert<
      QueryUserDataFunctionAuth>(json['functionAuth']);
  if (functionAuth != null) {
    queryUserData.functionAuth = functionAuth;
  }
  final String? role = jsonConvert.convert<String>(json['role']);
  if (role != null) {
    queryUserData.role = role;
  }
  final String? gmtModify = jsonConvert.convert<String>(json['gmtModify']);
  if (gmtModify != null) {
    queryUserData.gmtModify = gmtModify;
  }
  final int? albumNum = jsonConvert.convert<int>(json['albumNum']);
  if (albumNum != null) {
    queryUserData.albumNum = albumNum;
  }
  final String? multiLang = jsonConvert.convert<String>(json['multiLang']);
  if (multiLang != null) {
    queryUserData.multiLang = multiLang;
  }
  final dynamic specialId = json['specialId'];
  if (specialId != null) {
    queryUserData.specialId = specialId;
  }
  final String? cityName = jsonConvert.convert<String>(json['cityName']);
  if (cityName != null) {
    queryUserData.cityName = cityName;
  }
  final String? countryCode = jsonConvert.convert<String>(json['countryCode']);
  if (countryCode != null) {
    queryUserData.countryCode = countryCode;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    queryUserData.nickname = nickname;
  }
  final dynamic privateVideoUrl = json['privateVideoUrl'];
  if (privateVideoUrl != null) {
    queryUserData.privateVideoUrl = privateVideoUrl;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    queryUserData.lang = lang;
  }
  final int? secretNum = jsonConvert.convert<int>(json['secretNum']);
  if (secretNum != null) {
    queryUserData.secretNum = secretNum;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    queryUserData.email = email;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    queryUserData.sex = sex;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    queryUserData.mobile = mobile;
  }
  final String? gmtCreate = jsonConvert.convert<String>(json['gmtCreate']);
  if (gmtCreate != null) {
    queryUserData.gmtCreate = gmtCreate;
  }
  final dynamic tagUrlList = json['tagUrlList'];
  if (tagUrlList != null) {
    queryUserData.tagUrlList = tagUrlList;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    queryUserData.userId = userId;
  }
  final bool? newUser = jsonConvert.convert<bool>(json['newUser']);
  if (newUser != null) {
    queryUserData.newUser = newUser;
  }
  final dynamic invitationH5 = json['invitationH5'];
  if (invitationH5 != null) {
    queryUserData.invitationH5 = invitationH5;
  }
  final dynamic isRegister = json['isRegister'];
  if (isRegister != null) {
    queryUserData.isRegister = isRegister;
  }
  return queryUserData;
}

Map<String, dynamic> $QueryUserDataToJson(QueryUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['charmLevel'] = entity.charmLevel;
  data['channel'] = entity.channel;
  data['source'] = entity.source;
  data['cityId'] = entity.cityId;
  data['empty'] = entity.empty;
  data['vsId'] = entity.vsId;
  data['advertAaid'] = entity.advertAaid;
  data['initBasicInfoBySystem'] = entity.initBasicInfoBySystem;
  data['appId'] = entity.appId;
  data['pris'] = entity.pris;
  data['appKey'] = entity.appKey;
  data['id'] = entity.id;
  data['lat'] = entity.lat;
  data['area'] = entity.area;
  data['headImg'] = entity.headImg;
  data['lng'] = entity.lng;
  data['productId'] = entity.productId;
  data['level'] = entity.level;
  data['invitation'] = entity.invitation;
  data['extendInfo'] = entity.extendInfo;
  data['authInfo'] = entity.authInfo;
  data['privatePhotoUrl'] = entity.privatePhotoUrl;
  data['name'] = entity.name;
  data['campaign'] = entity.campaign;
  data['abResult'] = entity.abResult;
  data['displayId'] = entity.displayId;
  data['device'] = entity.device;
  data['status'] = entity.status;
  data['birthday'] = entity.birthday;
  data['gmtLastLogin'] = entity.gmtLastLogin;
  data['functionAuth'] = entity.functionAuth?.toJson();
  data['role'] = entity.role;
  data['gmtModify'] = entity.gmtModify;
  data['albumNum'] = entity.albumNum;
  data['multiLang'] = entity.multiLang;
  data['specialId'] = entity.specialId;
  data['cityName'] = entity.cityName;
  data['countryCode'] = entity.countryCode;
  data['nickname'] = entity.nickname;
  data['privateVideoUrl'] = entity.privateVideoUrl;
  data['lang'] = entity.lang;
  data['secretNum'] = entity.secretNum;
  data['email'] = entity.email;
  data['sex'] = entity.sex;
  data['mobile'] = entity.mobile;
  data['gmtCreate'] = entity.gmtCreate;
  data['tagUrlList'] = entity.tagUrlList;
  data['userId'] = entity.userId;
  data['newUser'] = entity.newUser;
  data['invitationH5'] = entity.invitationH5;
  data['isRegister'] = entity.isRegister;
  return data;
}

extension QueryUserDataExtension on QueryUserData {
  QueryUserData copyWith({
    int? charmLevel,
    int? channel,
    String? source,
    int? cityId,
    bool? empty,
    String? vsId,
    dynamic advertAaid,
    dynamic initBasicInfoBySystem,
    String? appId,
    List<dynamic>? pris,
    dynamic appKey,
    int? id,
    double? lat,
    String? area,
    String? headImg,
    double? lng,
    int? productId,
    int? level,
    dynamic invitation,
    String? extendInfo,
    String? authInfo,
    dynamic privatePhotoUrl,
    String? name,
    String? campaign,
    dynamic abResult,
    int? displayId,
    String? device,
    int? status,
    String? birthday,
    String? gmtLastLogin,
    QueryUserDataFunctionAuth? functionAuth,
    String? role,
    String? gmtModify,
    int? albumNum,
    String? multiLang,
    dynamic specialId,
    String? cityName,
    String? countryCode,
    String? nickname,
    dynamic privateVideoUrl,
    String? lang,
    int? secretNum,
    String? email,
    int? sex,
    String? mobile,
    String? gmtCreate,
    dynamic tagUrlList,
    String? userId,
    bool? newUser,
    dynamic invitationH5,
    dynamic isRegister,
  }) {
    return QueryUserData()
      ..charmLevel = charmLevel ?? this.charmLevel
      ..channel = channel ?? this.channel
      ..source = source ?? this.source
      ..cityId = cityId ?? this.cityId
      ..empty = empty ?? this.empty
      ..vsId = vsId ?? this.vsId
      ..advertAaid = advertAaid ?? this.advertAaid
      ..initBasicInfoBySystem = initBasicInfoBySystem ??
          this.initBasicInfoBySystem
      ..appId = appId ?? this.appId
      ..pris = pris ?? this.pris
      ..appKey = appKey ?? this.appKey
      ..id = id ?? this.id
      ..lat = lat ?? this.lat
      ..area = area ?? this.area
      ..headImg = headImg ?? this.headImg
      ..lng = lng ?? this.lng
      ..productId = productId ?? this.productId
      ..level = level ?? this.level
      ..invitation = invitation ?? this.invitation
      ..extendInfo = extendInfo ?? this.extendInfo
      ..authInfo = authInfo ?? this.authInfo
      ..privatePhotoUrl = privatePhotoUrl ?? this.privatePhotoUrl
      ..name = name ?? this.name
      ..campaign = campaign ?? this.campaign
      ..abResult = abResult ?? this.abResult
      ..displayId = displayId ?? this.displayId
      ..device = device ?? this.device
      ..status = status ?? this.status
      ..birthday = birthday ?? this.birthday
      ..gmtLastLogin = gmtLastLogin ?? this.gmtLastLogin
      ..functionAuth = functionAuth ?? this.functionAuth
      ..role = role ?? this.role
      ..gmtModify = gmtModify ?? this.gmtModify
      ..albumNum = albumNum ?? this.albumNum
      ..multiLang = multiLang ?? this.multiLang
      ..specialId = specialId ?? this.specialId
      ..cityName = cityName ?? this.cityName
      ..countryCode = countryCode ?? this.countryCode
      ..nickname = nickname ?? this.nickname
      ..privateVideoUrl = privateVideoUrl ?? this.privateVideoUrl
      ..lang = lang ?? this.lang
      ..secretNum = secretNum ?? this.secretNum
      ..email = email ?? this.email
      ..sex = sex ?? this.sex
      ..mobile = mobile ?? this.mobile
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..tagUrlList = tagUrlList ?? this.tagUrlList
      ..userId = userId ?? this.userId
      ..newUser = newUser ?? this.newUser
      ..invitationH5 = invitationH5 ?? this.invitationH5
      ..isRegister = isRegister ?? this.isRegister;
  }
}

QueryUserDataFunctionAuth $QueryUserDataFunctionAuthFromJson(
    Map<String, dynamic> json) {
  final QueryUserDataFunctionAuth queryUserDataFunctionAuth = QueryUserDataFunctionAuth();
  final dynamic enableMatchBot = json['enableMatchBot'];
  if (enableMatchBot != null) {
    queryUserDataFunctionAuth.enableMatchBot = enableMatchBot;
  }
  final dynamic enableBuyVip = json['enableBuyVip'];
  if (enableBuyVip != null) {
    queryUserDataFunctionAuth.enableBuyVip = enableBuyVip;
  }
  final dynamic enableMsgBot = json['enableMsgBot'];
  if (enableMsgBot != null) {
    queryUserDataFunctionAuth.enableMsgBot = enableMsgBot;
  }
  final bool? enableScreenshot = jsonConvert.convert<bool>(
      json['enableScreenshot']);
  if (enableScreenshot != null) {
    queryUserDataFunctionAuth.enableScreenshot = enableScreenshot;
  }
  final dynamic putInUser = json['putInUser'];
  if (putInUser != null) {
    queryUserDataFunctionAuth.putInUser = putInUser;
  }
  final dynamic enableFourthPay = json['enableFourthPay'];
  if (enableFourthPay != null) {
    queryUserDataFunctionAuth.enableFourthPay = enableFourthPay;
  }
  final dynamic enableUseVoiceRoom = json['enableUseVoiceRoom'];
  if (enableUseVoiceRoom != null) {
    queryUserDataFunctionAuth.enableUseVoiceRoom = enableUseVoiceRoom;
  }
  final dynamic enableRoomTab = json['enableRoomTab'];
  if (enableRoomTab != null) {
    queryUserDataFunctionAuth.enableRoomTab = enableRoomTab;
  }
  final dynamic naturalUser = json['naturalUser'];
  if (naturalUser != null) {
    queryUserDataFunctionAuth.naturalUser = naturalUser;
  }
  return queryUserDataFunctionAuth;
}

Map<String, dynamic> $QueryUserDataFunctionAuthToJson(
    QueryUserDataFunctionAuth entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enableMatchBot'] = entity.enableMatchBot;
  data['enableBuyVip'] = entity.enableBuyVip;
  data['enableMsgBot'] = entity.enableMsgBot;
  data['enableScreenshot'] = entity.enableScreenshot;
  data['putInUser'] = entity.putInUser;
  data['enableFourthPay'] = entity.enableFourthPay;
  data['enableUseVoiceRoom'] = entity.enableUseVoiceRoom;
  data['enableRoomTab'] = entity.enableRoomTab;
  data['naturalUser'] = entity.naturalUser;
  return data;
}

extension QueryUserDataFunctionAuthExtension on QueryUserDataFunctionAuth {
  QueryUserDataFunctionAuth copyWith({
    dynamic enableMatchBot,
    dynamic enableBuyVip,
    dynamic enableMsgBot,
    bool? enableScreenshot,
    dynamic putInUser,
    dynamic enableFourthPay,
    dynamic enableUseVoiceRoom,
    dynamic enableRoomTab,
    dynamic naturalUser,
  }) {
    return QueryUserDataFunctionAuth()
      ..enableMatchBot = enableMatchBot ?? this.enableMatchBot
      ..enableBuyVip = enableBuyVip ?? this.enableBuyVip
      ..enableMsgBot = enableMsgBot ?? this.enableMsgBot
      ..enableScreenshot = enableScreenshot ?? this.enableScreenshot
      ..putInUser = putInUser ?? this.putInUser
      ..enableFourthPay = enableFourthPay ?? this.enableFourthPay
      ..enableUseVoiceRoom = enableUseVoiceRoom ?? this.enableUseVoiceRoom
      ..enableRoomTab = enableRoomTab ?? this.enableRoomTab
      ..naturalUser = naturalUser ?? this.naturalUser;
  }
}