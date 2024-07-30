import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/sed/model/user_ai_tag_enums_entity.dart';

UserAiTagEnumsEntity $UserAiTagEnumsEntityFromJson(Map<String, dynamic> json) {
  final UserAiTagEnumsEntity userAiTagEnumsEntity = UserAiTagEnumsEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    userAiTagEnumsEntity.code = code;
  }
  final UserAiTagEnumsData? data = jsonConvert.convert<UserAiTagEnumsData>(
      json['data']);
  if (data != null) {
    userAiTagEnumsEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    userAiTagEnumsEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    userAiTagEnumsEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userAiTagEnumsEntity.message = message;
  }
  return userAiTagEnumsEntity;
}

Map<String, dynamic> $UserAiTagEnumsEntityToJson(UserAiTagEnumsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension UserAiTagEnumsEntityExtension on UserAiTagEnumsEntity {
  UserAiTagEnumsEntity copyWith({
    int? code,
    UserAiTagEnumsData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return UserAiTagEnumsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

UserAiTagEnumsData $UserAiTagEnumsDataFromJson(Map<String, dynamic> json) {
  final UserAiTagEnumsData userAiTagEnumsData = UserAiTagEnumsData();
  final List<
      UserAiTagEnumsDataPersonality>? personality = (json['personality'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<UserAiTagEnumsDataPersonality>(
          e) as UserAiTagEnumsDataPersonality).toList();
  if (personality != null) {
    userAiTagEnumsData.personality = personality;
  }
  final List<UserAiTagEnumsDataPurpose>? purpose = (json['purpose'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<UserAiTagEnumsDataPurpose>(
          e) as UserAiTagEnumsDataPurpose).toList();
  if (purpose != null) {
    userAiTagEnumsData.purpose = purpose;
  }
  final List<UserAiTagEnumsDataInterest>? interest = (json['interest'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<UserAiTagEnumsDataInterest>(
          e) as UserAiTagEnumsDataInterest).toList();
  if (interest != null) {
    userAiTagEnumsData.interest = interest;
  }
  final dynamic appId = json['appId'];
  if (appId != null) {
    userAiTagEnumsData.appId = appId;
  }
  final dynamic userId = json['userId'];
  if (userId != null) {
    userAiTagEnumsData.userId = userId;
  }
  return userAiTagEnumsData;
}

Map<String, dynamic> $UserAiTagEnumsDataToJson(UserAiTagEnumsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['personality'] = entity.personality?.map((v) => v.toJson()).toList();
  data['purpose'] = entity.purpose?.map((v) => v.toJson()).toList();
  data['interest'] = entity.interest?.map((v) => v.toJson()).toList();
  data['appId'] = entity.appId;
  data['userId'] = entity.userId;
  return data;
}

extension UserAiTagEnumsDataExtension on UserAiTagEnumsData {
  UserAiTagEnumsData copyWith({
    List<UserAiTagEnumsDataPersonality>? personality,
    List<UserAiTagEnumsDataPurpose>? purpose,
    List<UserAiTagEnumsDataInterest>? interest,
    dynamic appId,
    dynamic userId,
  }) {
    return UserAiTagEnumsData()
      ..personality = personality ?? this.personality
      ..purpose = purpose ?? this.purpose
      ..interest = interest ?? this.interest
      ..appId = appId ?? this.appId
      ..userId = userId ?? this.userId;
  }
}

UserAiTagEnumsDataPersonality $UserAiTagEnumsDataPersonalityFromJson(
    Map<String, dynamic> json) {
  final UserAiTagEnumsDataPersonality userAiTagEnumsDataPersonality = UserAiTagEnumsDataPersonality();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userAiTagEnumsDataPersonality.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    userAiTagEnumsDataPersonality.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    userAiTagEnumsDataPersonality.desc = desc;
  }
  return userAiTagEnumsDataPersonality;
}

Map<String, dynamic> $UserAiTagEnumsDataPersonalityToJson(
    UserAiTagEnumsDataPersonality entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension UserAiTagEnumsDataPersonalityExtension on UserAiTagEnumsDataPersonality {
  UserAiTagEnumsDataPersonality copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return UserAiTagEnumsDataPersonality()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}

UserAiTagEnumsDataPurpose $UserAiTagEnumsDataPurposeFromJson(
    Map<String, dynamic> json) {
  final UserAiTagEnumsDataPurpose userAiTagEnumsDataPurpose = UserAiTagEnumsDataPurpose();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userAiTagEnumsDataPurpose.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    userAiTagEnumsDataPurpose.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    userAiTagEnumsDataPurpose.desc = desc;
  }
  return userAiTagEnumsDataPurpose;
}

Map<String, dynamic> $UserAiTagEnumsDataPurposeToJson(
    UserAiTagEnumsDataPurpose entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension UserAiTagEnumsDataPurposeExtension on UserAiTagEnumsDataPurpose {
  UserAiTagEnumsDataPurpose copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return UserAiTagEnumsDataPurpose()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}

UserAiTagEnumsDataInterest $UserAiTagEnumsDataInterestFromJson(
    Map<String, dynamic> json) {
  final UserAiTagEnumsDataInterest userAiTagEnumsDataInterest = UserAiTagEnumsDataInterest();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userAiTagEnumsDataInterest.id = id;
  }
  final dynamic url = json['url'];
  if (url != null) {
    userAiTagEnumsDataInterest.url = url;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    userAiTagEnumsDataInterest.desc = desc;
  }
  return userAiTagEnumsDataInterest;
}

Map<String, dynamic> $UserAiTagEnumsDataInterestToJson(
    UserAiTagEnumsDataInterest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['desc'] = entity.desc;
  return data;
}

extension UserAiTagEnumsDataInterestExtension on UserAiTagEnumsDataInterest {
  UserAiTagEnumsDataInterest copyWith({
    int? id,
    dynamic url,
    String? desc,
  }) {
    return UserAiTagEnumsDataInterest()
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..desc = desc ?? this.desc;
  }
}