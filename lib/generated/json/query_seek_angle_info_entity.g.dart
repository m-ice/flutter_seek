import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/sed/model/query_seek_angle_info_entity.dart';

QuerySeekAngleInfoEntity $QuerySeekAngleInfoEntityFromJson(
    Map<String, dynamic> json) {
  final QuerySeekAngleInfoEntity querySeekAngleInfoEntity = QuerySeekAngleInfoEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    querySeekAngleInfoEntity.code = code;
  }
  final QuerySeekAngleInfoData? data = jsonConvert.convert<
      QuerySeekAngleInfoData>(json['data']);
  if (data != null) {
    querySeekAngleInfoEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    querySeekAngleInfoEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    querySeekAngleInfoEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    querySeekAngleInfoEntity.message = message;
  }
  return querySeekAngleInfoEntity;
}

Map<String, dynamic> $QuerySeekAngleInfoEntityToJson(
    QuerySeekAngleInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension QuerySeekAngleInfoEntityExtension on QuerySeekAngleInfoEntity {
  QuerySeekAngleInfoEntity copyWith({
    int? code,
    QuerySeekAngleInfoData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return QuerySeekAngleInfoEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

QuerySeekAngleInfoData $QuerySeekAngleInfoDataFromJson(
    Map<String, dynamic> json) {
  final QuerySeekAngleInfoData querySeekAngleInfoData = QuerySeekAngleInfoData();
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    querySeekAngleInfoData.birthday = birthday;
  }
  final String? headImg = jsonConvert.convert<String>(json['headImg']);
  if (headImg != null) {
    querySeekAngleInfoData.headImg = headImg;
  }
  final dynamic distance = json['distance'];
  if (distance != null) {
    querySeekAngleInfoData.distance = distance;
  }
  final List<QuerySeekAngleInfoDataPurpose>? purpose = (json['purpose'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QuerySeekAngleInfoDataPurpose>(
          e) as QuerySeekAngleInfoDataPurpose).toList();
  if (purpose != null) {
    querySeekAngleInfoData.purpose = purpose;
  }
  final dynamic onlineStatus = json['onlineStatus'];
  if (onlineStatus != null) {
    querySeekAngleInfoData.onlineStatus = onlineStatus;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    querySeekAngleInfoData.sex = sex;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    querySeekAngleInfoData.description = description;
  }
  final dynamic userId = json['userId'];
  if (userId != null) {
    querySeekAngleInfoData.userId = userId;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    querySeekAngleInfoData.uid = uid;
  }
  final List<
      QuerySeekAngleInfoDataPersonality>? personality = (json['personality'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QuerySeekAngleInfoDataPersonality>(
          e) as QuerySeekAngleInfoDataPersonality).toList();
  if (personality != null) {
    querySeekAngleInfoData.personality = personality;
  }
  final List<
      QuerySeekAngleInfoDataInterest>? interest = (json['interest'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QuerySeekAngleInfoDataInterest>(
          e) as QuerySeekAngleInfoDataInterest).toList();
  if (interest != null) {
    querySeekAngleInfoData.interest = interest;
  }
  final dynamic appId = json['appId'];
  if (appId != null) {
    querySeekAngleInfoData.appId = appId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    querySeekAngleInfoData.nickname = nickname;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    querySeekAngleInfoData.age = age;
  }
  final List<String>? covers = (json['covers'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (covers != null) {
    querySeekAngleInfoData.covers = covers;
  }
  return querySeekAngleInfoData;
}

Map<String, dynamic> $QuerySeekAngleInfoDataToJson(
    QuerySeekAngleInfoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['birthday'] = entity.birthday;
  data['headImg'] = entity.headImg;
  data['distance'] = entity.distance;
  data['purpose'] = entity.purpose?.map((v) => v.toJson()).toList();
  data['onlineStatus'] = entity.onlineStatus;
  data['sex'] = entity.sex;
  data['description'] = entity.description;
  data['userId'] = entity.userId;
  data['uid'] = entity.uid;
  data['personality'] = entity.personality?.map((v) => v.toJson()).toList();
  data['interest'] = entity.interest?.map((v) => v.toJson()).toList();
  data['appId'] = entity.appId;
  data['nickname'] = entity.nickname;
  data['age'] = entity.age;
  data['covers'] = entity.covers;
  return data;
}

extension QuerySeekAngleInfoDataExtension on QuerySeekAngleInfoData {
  QuerySeekAngleInfoData copyWith({
    String? birthday,
    String? headImg,
    dynamic distance,
    List<QuerySeekAngleInfoDataPurpose>? purpose,
    dynamic onlineStatus,
    int? sex,
    String? description,
    dynamic userId,
    dynamic uid,
    List<QuerySeekAngleInfoDataPersonality>? personality,
    List<QuerySeekAngleInfoDataInterest>? interest,
    dynamic appId,
    String? nickname,
    int? age,
    List<String>? covers,
  }) {
    return QuerySeekAngleInfoData()
      ..birthday = birthday ?? this.birthday
      ..headImg = headImg ?? this.headImg
      ..distance = distance ?? this.distance
      ..purpose = purpose ?? this.purpose
      ..onlineStatus = onlineStatus ?? this.onlineStatus
      ..sex = sex ?? this.sex
      ..description = description ?? this.description
      ..userId = userId ?? this.userId
      ..uid = uid ?? this.uid
      ..personality = personality ?? this.personality
      ..interest = interest ?? this.interest
      ..appId = appId ?? this.appId
      ..nickname = nickname ?? this.nickname
      ..age = age ?? this.age
      ..covers = covers ?? this.covers;
  }
}

QuerySeekAngleInfoDataPurpose $QuerySeekAngleInfoDataPurposeFromJson(
    Map<String, dynamic> json) {
  final QuerySeekAngleInfoDataPurpose querySeekAngleInfoDataPurpose = QuerySeekAngleInfoDataPurpose();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    querySeekAngleInfoDataPurpose.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    querySeekAngleInfoDataPurpose.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    querySeekAngleInfoDataPurpose.desc = desc;
  }
  return querySeekAngleInfoDataPurpose;
}

Map<String, dynamic> $QuerySeekAngleInfoDataPurposeToJson(
    QuerySeekAngleInfoDataPurpose entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension QuerySeekAngleInfoDataPurposeExtension on QuerySeekAngleInfoDataPurpose {
  QuerySeekAngleInfoDataPurpose copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return QuerySeekAngleInfoDataPurpose()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}

QuerySeekAngleInfoDataPersonality $QuerySeekAngleInfoDataPersonalityFromJson(
    Map<String, dynamic> json) {
  final QuerySeekAngleInfoDataPersonality querySeekAngleInfoDataPersonality = QuerySeekAngleInfoDataPersonality();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    querySeekAngleInfoDataPersonality.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    querySeekAngleInfoDataPersonality.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    querySeekAngleInfoDataPersonality.desc = desc;
  }
  return querySeekAngleInfoDataPersonality;
}

Map<String, dynamic> $QuerySeekAngleInfoDataPersonalityToJson(
    QuerySeekAngleInfoDataPersonality entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension QuerySeekAngleInfoDataPersonalityExtension on QuerySeekAngleInfoDataPersonality {
  QuerySeekAngleInfoDataPersonality copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return QuerySeekAngleInfoDataPersonality()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}

QuerySeekAngleInfoDataInterest $QuerySeekAngleInfoDataInterestFromJson(
    Map<String, dynamic> json) {
  final QuerySeekAngleInfoDataInterest querySeekAngleInfoDataInterest = QuerySeekAngleInfoDataInterest();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    querySeekAngleInfoDataInterest.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    querySeekAngleInfoDataInterest.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    querySeekAngleInfoDataInterest.desc = desc;
  }
  return querySeekAngleInfoDataInterest;
}

Map<String, dynamic> $QuerySeekAngleInfoDataInterestToJson(
    QuerySeekAngleInfoDataInterest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension QuerySeekAngleInfoDataInterestExtension on QuerySeekAngleInfoDataInterest {
  QuerySeekAngleInfoDataInterest copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return QuerySeekAngleInfoDataInterest()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}