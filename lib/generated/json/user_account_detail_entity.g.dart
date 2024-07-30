import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/user_account_detail_entity.dart';

UserAccountDetailEntity $UserAccountDetailEntityFromJson(
    Map<String, dynamic> json) {
  final UserAccountDetailEntity userAccountDetailEntity = UserAccountDetailEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    userAccountDetailEntity.code = code;
  }
  final UserAccountDetailData? data = jsonConvert.convert<
      UserAccountDetailData>(json['data']);
  if (data != null) {
    userAccountDetailEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    userAccountDetailEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    userAccountDetailEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userAccountDetailEntity.message = message;
  }
  return userAccountDetailEntity;
}

Map<String, dynamic> $UserAccountDetailEntityToJson(
    UserAccountDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension UserAccountDetailEntityExtension on UserAccountDetailEntity {
  UserAccountDetailEntity copyWith({
    int? code,
    UserAccountDetailData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return UserAccountDetailEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

UserAccountDetailData $UserAccountDetailDataFromJson(
    Map<String, dynamic> json) {
  final UserAccountDetailData userAccountDetailData = UserAccountDetailData();
  final dynamic hitSongCount = json['hitSongCount'];
  if (hitSongCount != null) {
    userAccountDetailData.hitSongCount = hitSongCount;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    userAccountDetailData.diamonds = diamonds;
  }
  final dynamic gmtModify = json['gmtModify'];
  if (gmtModify != null) {
    userAccountDetailData.gmtModify = gmtModify;
  }
  final int? agentLimit = jsonConvert.convert<int>(json['agentLimit']);
  if (agentLimit != null) {
    userAccountDetailData.agentLimit = agentLimit;
  }
  final double? vigor = jsonConvert.convert<double>(json['vigor']);
  if (vigor != null) {
    userAccountDetailData.vigor = vigor;
  }
  final dynamic nobleExpire = json['nobleExpire'];
  if (nobleExpire != null) {
    userAccountDetailData.nobleExpire = nobleExpire;
  }
  final dynamic nobleBuyWay = json['nobleBuyWay'];
  if (nobleBuyWay != null) {
    userAccountDetailData.nobleBuyWay = nobleBuyWay;
  }
  final int? gold = jsonConvert.convert<int>(json['gold']);
  if (gold != null) {
    userAccountDetailData.gold = gold;
  }
  final dynamic rideLevel = json['rideLevel'];
  if (rideLevel != null) {
    userAccountDetailData.rideLevel = rideLevel;
  }
  final dynamic vipLevel = json['vipLevel'];
  if (vipLevel != null) {
    userAccountDetailData.vipLevel = vipLevel;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    userAccountDetailData.appId = appId;
  }
  final dynamic id = json['id'];
  if (id != null) {
    userAccountDetailData.id = id;
  }
  final dynamic productId = json['productId'];
  if (productId != null) {
    userAccountDetailData.productId = productId;
  }
  final int? userGrade = jsonConvert.convert<int>(json['userGrade']);
  if (userGrade != null) {
    userAccountDetailData.userGrade = userGrade;
  }
  final dynamic cashOutVigor = json['cashOutVigor'];
  if (cashOutVigor != null) {
    userAccountDetailData.cashOutVigor = cashOutVigor;
  }
  final dynamic follows = json['follows'];
  if (follows != null) {
    userAccountDetailData.follows = follows;
  }
  final dynamic vipType = json['vipType'];
  if (vipType != null) {
    userAccountDetailData.vipType = vipType;
  }
  final dynamic gmtCreate = json['gmtCreate'];
  if (gmtCreate != null) {
    userAccountDetailData.gmtCreate = gmtCreate;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userAccountDetailData.userId = userId;
  }
  final dynamic anchorLevel = json['anchorLevel'];
  if (anchorLevel != null) {
    userAccountDetailData.anchorLevel = anchorLevel;
  }
  final dynamic nobleLevel = json['nobleLevel'];
  if (nobleLevel != null) {
    userAccountDetailData.nobleLevel = nobleLevel;
  }
  final dynamic fans = json['fans'];
  if (fans != null) {
    userAccountDetailData.fans = fans;
  }
  final dynamic vipExpire = json['vipExpire'];
  if (vipExpire != null) {
    userAccountDetailData.vipExpire = vipExpire;
  }
  final int? vipStatus = jsonConvert.convert<int>(json['vipStatus']);
  if (vipStatus != null) {
    userAccountDetailData.vipStatus = vipStatus;
  }
  final dynamic richLevel = json['richLevel'];
  if (richLevel != null) {
    userAccountDetailData.richLevel = richLevel;
  }
  final int? payStatus = jsonConvert.convert<int>(json['payStatus']);
  if (payStatus != null) {
    userAccountDetailData.payStatus = payStatus;
  }
  return userAccountDetailData;
}

Map<String, dynamic> $UserAccountDetailDataToJson(
    UserAccountDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hitSongCount'] = entity.hitSongCount;
  data['diamonds'] = entity.diamonds;
  data['gmtModify'] = entity.gmtModify;
  data['agentLimit'] = entity.agentLimit;
  data['vigor'] = entity.vigor;
  data['nobleExpire'] = entity.nobleExpire;
  data['nobleBuyWay'] = entity.nobleBuyWay;
  data['gold'] = entity.gold;
  data['rideLevel'] = entity.rideLevel;
  data['vipLevel'] = entity.vipLevel;
  data['appId'] = entity.appId;
  data['id'] = entity.id;
  data['productId'] = entity.productId;
  data['userGrade'] = entity.userGrade;
  data['cashOutVigor'] = entity.cashOutVigor;
  data['follows'] = entity.follows;
  data['vipType'] = entity.vipType;
  data['gmtCreate'] = entity.gmtCreate;
  data['userId'] = entity.userId;
  data['anchorLevel'] = entity.anchorLevel;
  data['nobleLevel'] = entity.nobleLevel;
  data['fans'] = entity.fans;
  data['vipExpire'] = entity.vipExpire;
  data['vipStatus'] = entity.vipStatus;
  data['richLevel'] = entity.richLevel;
  data['payStatus'] = entity.payStatus;
  return data;
}

extension UserAccountDetailDataExtension on UserAccountDetailData {
  UserAccountDetailData copyWith({
    dynamic hitSongCount,
    int? diamonds,
    dynamic gmtModify,
    int? agentLimit,
    double? vigor,
    dynamic nobleExpire,
    dynamic nobleBuyWay,
    int? gold,
    dynamic rideLevel,
    dynamic vipLevel,
    String? appId,
    dynamic id,
    dynamic productId,
    int? userGrade,
    dynamic cashOutVigor,
    dynamic follows,
    dynamic vipType,
    dynamic gmtCreate,
    String? userId,
    dynamic anchorLevel,
    dynamic nobleLevel,
    dynamic fans,
    dynamic vipExpire,
    int? vipStatus,
    dynamic richLevel,
    int? payStatus,
  }) {
    return UserAccountDetailData()
      ..hitSongCount = hitSongCount ?? this.hitSongCount
      ..diamonds = diamonds ?? this.diamonds
      ..gmtModify = gmtModify ?? this.gmtModify
      ..agentLimit = agentLimit ?? this.agentLimit
      ..vigor = vigor ?? this.vigor
      ..nobleExpire = nobleExpire ?? this.nobleExpire
      ..nobleBuyWay = nobleBuyWay ?? this.nobleBuyWay
      ..gold = gold ?? this.gold
      ..rideLevel = rideLevel ?? this.rideLevel
      ..vipLevel = vipLevel ?? this.vipLevel
      ..appId = appId ?? this.appId
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..userGrade = userGrade ?? this.userGrade
      ..cashOutVigor = cashOutVigor ?? this.cashOutVigor
      ..follows = follows ?? this.follows
      ..vipType = vipType ?? this.vipType
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..userId = userId ?? this.userId
      ..anchorLevel = anchorLevel ?? this.anchorLevel
      ..nobleLevel = nobleLevel ?? this.nobleLevel
      ..fans = fans ?? this.fans
      ..vipExpire = vipExpire ?? this.vipExpire
      ..vipStatus = vipStatus ?? this.vipStatus
      ..richLevel = richLevel ?? this.richLevel
      ..payStatus = payStatus ?? this.payStatus;
  }
}