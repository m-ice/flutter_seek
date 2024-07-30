import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/login/model/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    loginEntity.code = code;
  }
  final LoginData? data = jsonConvert.convert<LoginData>(json['data']);
  if (data != null) {
    loginEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    loginEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    loginEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    loginEntity.message = message;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    int? code,
    LoginData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return LoginEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

LoginData $LoginDataFromJson(Map<String, dynamic> json) {
  final LoginData loginData = LoginData();
  final dynamic outRole = json['outRole'];
  if (outRole != null) {
    loginData.outRole = outRole;
  }
  final LoginDataUserInfo? userInfo = jsonConvert.convert<LoginDataUserInfo>(
      json['userInfo']);
  if (userInfo != null) {
    loginData.userInfo = userInfo;
  }
  final dynamic needGuide = json['needGuide'];
  if (needGuide != null) {
    loginData.needGuide = needGuide;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    loginData.token = token;
  }
  final dynamic svipBound = json['svipBound'];
  if (svipBound != null) {
    loginData.svipBound = svipBound;
  }
  return loginData;
}

Map<String, dynamic> $LoginDataToJson(LoginData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['outRole'] = entity.outRole;
  data['userInfo'] = entity.userInfo?.toJson();
  data['needGuide'] = entity.needGuide;
  data['token'] = entity.token;
  data['svipBound'] = entity.svipBound;
  return data;
}

extension LoginDataExtension on LoginData {
  LoginData copyWith({
    dynamic outRole,
    LoginDataUserInfo? userInfo,
    dynamic needGuide,
    String? token,
    dynamic svipBound,
  }) {
    return LoginData()
      ..outRole = outRole ?? this.outRole
      ..userInfo = userInfo ?? this.userInfo
      ..needGuide = needGuide ?? this.needGuide
      ..token = token ?? this.token
      ..svipBound = svipBound ?? this.svipBound;
  }
}

LoginDataUserInfo $LoginDataUserInfoFromJson(Map<String, dynamic> json) {
  final LoginDataUserInfo loginDataUserInfo = LoginDataUserInfo();
  final dynamic charmLevel = json['charmLevel'];
  if (charmLevel != null) {
    loginDataUserInfo.charmLevel = charmLevel;
  }
  final int? channel = jsonConvert.convert<int>(json['channel']);
  if (channel != null) {
    loginDataUserInfo.channel = channel;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    loginDataUserInfo.source = source;
  }
  final int? cityId = jsonConvert.convert<int>(json['cityId']);
  if (cityId != null) {
    loginDataUserInfo.cityId = cityId;
  }
  final bool? empty = jsonConvert.convert<bool>(json['empty']);
  if (empty != null) {
    loginDataUserInfo.empty = empty;
  }
  final String? vsId = jsonConvert.convert<String>(json['vsId']);
  if (vsId != null) {
    loginDataUserInfo.vsId = vsId;
  }
  final dynamic advertAaid = json['advertAaid'];
  if (advertAaid != null) {
    loginDataUserInfo.advertAaid = advertAaid;
  }
  final dynamic initBasicInfoBySystem = json['initBasicInfoBySystem'];
  if (initBasicInfoBySystem != null) {
    loginDataUserInfo.initBasicInfoBySystem = initBasicInfoBySystem;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    loginDataUserInfo.appId = appId;
  }
  final List<dynamic>? pris = (json['pris'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (pris != null) {
    loginDataUserInfo.pris = pris;
  }
  final String? appKey = jsonConvert.convert<String>(json['appKey']);
  if (appKey != null) {
    loginDataUserInfo.appKey = appKey;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    loginDataUserInfo.id = id;
  }
  final double? lat = jsonConvert.convert<double>(json['lat']);
  if (lat != null) {
    loginDataUserInfo.lat = lat;
  }
  final String? area = jsonConvert.convert<String>(json['area']);
  if (area != null) {
    loginDataUserInfo.area = area;
  }
  final String? headImg = jsonConvert.convert<String>(json['headImg']);
  if (headImg != null) {
    loginDataUserInfo.headImg = headImg;
  }
  final double? lng = jsonConvert.convert<double>(json['lng']);
  if (lng != null) {
    loginDataUserInfo.lng = lng;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    loginDataUserInfo.productId = productId;
  }
  final dynamic level = json['level'];
  if (level != null) {
    loginDataUserInfo.level = level;
  }
  final dynamic invitation = json['invitation'];
  if (invitation != null) {
    loginDataUserInfo.invitation = invitation;
  }
  final String? extendInfo = jsonConvert.convert<String>(json['extendInfo']);
  if (extendInfo != null) {
    loginDataUserInfo.extendInfo = extendInfo;
  }
  final String? authInfo = jsonConvert.convert<String>(json['authInfo']);
  if (authInfo != null) {
    loginDataUserInfo.authInfo = authInfo;
  }
  final dynamic privatePhotoUrl = json['privatePhotoUrl'];
  if (privatePhotoUrl != null) {
    loginDataUserInfo.privatePhotoUrl = privatePhotoUrl;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    loginDataUserInfo.name = name;
  }
  final String? campaign = jsonConvert.convert<String>(json['campaign']);
  if (campaign != null) {
    loginDataUserInfo.campaign = campaign;
  }
  final LoginDataUserInfoAbResult? abResult = jsonConvert.convert<
      LoginDataUserInfoAbResult>(json['abResult']);
  if (abResult != null) {
    loginDataUserInfo.abResult = abResult;
  }
  final int? displayId = jsonConvert.convert<int>(json['displayId']);
  if (displayId != null) {
    loginDataUserInfo.displayId = displayId;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    loginDataUserInfo.device = device;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    loginDataUserInfo.status = status;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    loginDataUserInfo.birthday = birthday;
  }
  final String? gmtLastLogin = jsonConvert.convert<String>(
      json['gmtLastLogin']);
  if (gmtLastLogin != null) {
    loginDataUserInfo.gmtLastLogin = gmtLastLogin;
  }
  final LoginDataUserInfoFunctionAuth? functionAuth = jsonConvert.convert<
      LoginDataUserInfoFunctionAuth>(json['functionAuth']);
  if (functionAuth != null) {
    loginDataUserInfo.functionAuth = functionAuth;
  }
  final String? role = jsonConvert.convert<String>(json['role']);
  if (role != null) {
    loginDataUserInfo.role = role;
  }
  final String? gmtModify = jsonConvert.convert<String>(json['gmtModify']);
  if (gmtModify != null) {
    loginDataUserInfo.gmtModify = gmtModify;
  }
  final int? albumNum = jsonConvert.convert<int>(json['albumNum']);
  if (albumNum != null) {
    loginDataUserInfo.albumNum = albumNum;
  }
  final String? multiLang = jsonConvert.convert<String>(json['multiLang']);
  if (multiLang != null) {
    loginDataUserInfo.multiLang = multiLang;
  }
  final dynamic specialId = json['specialId'];
  if (specialId != null) {
    loginDataUserInfo.specialId = specialId;
  }
  final String? cityName = jsonConvert.convert<String>(json['cityName']);
  if (cityName != null) {
    loginDataUserInfo.cityName = cityName;
  }
  final String? countryCode = jsonConvert.convert<String>(json['countryCode']);
  if (countryCode != null) {
    loginDataUserInfo.countryCode = countryCode;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    loginDataUserInfo.nickname = nickname;
  }
  final dynamic privateVideoUrl = json['privateVideoUrl'];
  if (privateVideoUrl != null) {
    loginDataUserInfo.privateVideoUrl = privateVideoUrl;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    loginDataUserInfo.lang = lang;
  }
  final int? secretNum = jsonConvert.convert<int>(json['secretNum']);
  if (secretNum != null) {
    loginDataUserInfo.secretNum = secretNum;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    loginDataUserInfo.email = email;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    loginDataUserInfo.sex = sex;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    loginDataUserInfo.mobile = mobile;
  }
  final String? gmtCreate = jsonConvert.convert<String>(json['gmtCreate']);
  if (gmtCreate != null) {
    loginDataUserInfo.gmtCreate = gmtCreate;
  }
  final dynamic tagUrlList = json['tagUrlList'];
  if (tagUrlList != null) {
    loginDataUserInfo.tagUrlList = tagUrlList;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    loginDataUserInfo.userId = userId;
  }
  final dynamic newUser = json['newUser'];
  if (newUser != null) {
    loginDataUserInfo.newUser = newUser;
  }
  final dynamic invitationH5 = json['invitationH5'];
  if (invitationH5 != null) {
    loginDataUserInfo.invitationH5 = invitationH5;
  }
  final int? isRegister = jsonConvert.convert<int>(json['isRegister']);
  if (isRegister != null) {
    loginDataUserInfo.isRegister = isRegister;
  }
  return loginDataUserInfo;
}

Map<String, dynamic> $LoginDataUserInfoToJson(LoginDataUserInfo entity) {
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
  data['abResult'] = entity.abResult?.toJson();
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

extension LoginDataUserInfoExtension on LoginDataUserInfo {
  LoginDataUserInfo copyWith({
    dynamic charmLevel,
    int? channel,
    String? source,
    int? cityId,
    bool? empty,
    String? vsId,
    dynamic advertAaid,
    dynamic initBasicInfoBySystem,
    String? appId,
    List<dynamic>? pris,
    String? appKey,
    int? id,
    double? lat,
    String? area,
    String? headImg,
    double? lng,
    int? productId,
    dynamic level,
    dynamic invitation,
    String? extendInfo,
    String? authInfo,
    dynamic privatePhotoUrl,
    String? name,
    String? campaign,
    LoginDataUserInfoAbResult? abResult,
    int? displayId,
    String? device,
    int? status,
    String? birthday,
    String? gmtLastLogin,
    LoginDataUserInfoFunctionAuth? functionAuth,
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
    dynamic newUser,
    dynamic invitationH5,
    int? isRegister,
  }) {
    return LoginDataUserInfo()
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

LoginDataUserInfoAbResult $LoginDataUserInfoAbResultFromJson(
    Map<String, dynamic> json) {
  final LoginDataUserInfoAbResult loginDataUserInfoAbResult = LoginDataUserInfoAbResult();
  return loginDataUserInfoAbResult;
}

Map<String, dynamic> $LoginDataUserInfoAbResultToJson(
    LoginDataUserInfoAbResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension LoginDataUserInfoAbResultExtension on LoginDataUserInfoAbResult {
}

LoginDataUserInfoFunctionAuth $LoginDataUserInfoFunctionAuthFromJson(
    Map<String, dynamic> json) {
  final LoginDataUserInfoFunctionAuth loginDataUserInfoFunctionAuth = LoginDataUserInfoFunctionAuth();
  final dynamic enableMatchBot = json['enableMatchBot'];
  if (enableMatchBot != null) {
    loginDataUserInfoFunctionAuth.enableMatchBot = enableMatchBot;
  }
  final dynamic enableBuyVip = json['enableBuyVip'];
  if (enableBuyVip != null) {
    loginDataUserInfoFunctionAuth.enableBuyVip = enableBuyVip;
  }
  final dynamic enableMsgBot = json['enableMsgBot'];
  if (enableMsgBot != null) {
    loginDataUserInfoFunctionAuth.enableMsgBot = enableMsgBot;
  }
  final bool? enableScreenshot = jsonConvert.convert<bool>(
      json['enableScreenshot']);
  if (enableScreenshot != null) {
    loginDataUserInfoFunctionAuth.enableScreenshot = enableScreenshot;
  }
  final dynamic putInUser = json['putInUser'];
  if (putInUser != null) {
    loginDataUserInfoFunctionAuth.putInUser = putInUser;
  }
  final dynamic enableFourthPay = json['enableFourthPay'];
  if (enableFourthPay != null) {
    loginDataUserInfoFunctionAuth.enableFourthPay = enableFourthPay;
  }
  final dynamic enableUseVoiceRoom = json['enableUseVoiceRoom'];
  if (enableUseVoiceRoom != null) {
    loginDataUserInfoFunctionAuth.enableUseVoiceRoom = enableUseVoiceRoom;
  }
  final dynamic enableRoomTab = json['enableRoomTab'];
  if (enableRoomTab != null) {
    loginDataUserInfoFunctionAuth.enableRoomTab = enableRoomTab;
  }
  final dynamic naturalUser = json['naturalUser'];
  if (naturalUser != null) {
    loginDataUserInfoFunctionAuth.naturalUser = naturalUser;
  }
  return loginDataUserInfoFunctionAuth;
}

Map<String, dynamic> $LoginDataUserInfoFunctionAuthToJson(
    LoginDataUserInfoFunctionAuth entity) {
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

extension LoginDataUserInfoFunctionAuthExtension on LoginDataUserInfoFunctionAuth {
  LoginDataUserInfoFunctionAuth copyWith({
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
    return LoginDataUserInfoFunctionAuth()
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