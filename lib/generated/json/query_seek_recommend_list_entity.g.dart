import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/sed/model/query_seek_recommend_list_entity.dart';

QuerySeekRecommendListEntity $QuerySeekRecommendListEntityFromJson(
    Map<String, dynamic> json) {
  final QuerySeekRecommendListEntity querySeekRecommendListEntity = QuerySeekRecommendListEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    querySeekRecommendListEntity.code = code;
  }
  final QuerySeekRecommendListData? data = jsonConvert.convert<
      QuerySeekRecommendListData>(json['data']);
  if (data != null) {
    querySeekRecommendListEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    querySeekRecommendListEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    querySeekRecommendListEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    querySeekRecommendListEntity.message = message;
  }
  return querySeekRecommendListEntity;
}

Map<String, dynamic> $QuerySeekRecommendListEntityToJson(
    QuerySeekRecommendListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension QuerySeekRecommendListEntityExtension on QuerySeekRecommendListEntity {
  QuerySeekRecommendListEntity copyWith({
    int? code,
    QuerySeekRecommendListData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return QuerySeekRecommendListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

QuerySeekRecommendListData $QuerySeekRecommendListDataFromJson(
    Map<String, dynamic> json) {
  final QuerySeekRecommendListData querySeekRecommendListData = QuerySeekRecommendListData();
  final int? normalCount = jsonConvert.convert<int>(json['normalCount']);
  if (normalCount != null) {
    querySeekRecommendListData.normalCount = normalCount;
  }
  final double? matchRate = jsonConvert.convert<double>(json['matchRate']);
  if (matchRate != null) {
    querySeekRecommendListData.matchRate = matchRate;
  }
  final List<
      QuerySeekRecommendListDataAngleList>? angleList = (json['angleList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QuerySeekRecommendListDataAngleList>(
          e) as QuerySeekRecommendListDataAngleList).toList();
  if (angleList != null) {
    querySeekRecommendListData.angleList = angleList;
  }
  return querySeekRecommendListData;
}

Map<String, dynamic> $QuerySeekRecommendListDataToJson(
    QuerySeekRecommendListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['normalCount'] = entity.normalCount;
  data['matchRate'] = entity.matchRate;
  data['angleList'] = entity.angleList?.map((v) => v.toJson()).toList();
  return data;
}

extension QuerySeekRecommendListDataExtension on QuerySeekRecommendListData {
  QuerySeekRecommendListData copyWith({
    int? normalCount,
    double? matchRate,
    List<QuerySeekRecommendListDataAngleList>? angleList,
  }) {
    return QuerySeekRecommendListData()
      ..normalCount = normalCount ?? this.normalCount
      ..matchRate = matchRate ?? this.matchRate
      ..angleList = angleList ?? this.angleList;
  }
}

QuerySeekRecommendListDataAngleList $QuerySeekRecommendListDataAngleListFromJson(
    Map<String, dynamic> json) {
  final QuerySeekRecommendListDataAngleList querySeekRecommendListDataAngleList = QuerySeekRecommendListDataAngleList();
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    querySeekRecommendListDataAngleList.birthday = birthday;
  }
  final String? headImg = jsonConvert.convert<String>(json['headImg']);
  if (headImg != null) {
    querySeekRecommendListDataAngleList.headImg = headImg;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    querySeekRecommendListDataAngleList.distance = distance;
  }
  final dynamic purpose = json['purpose'];
  if (purpose != null) {
    querySeekRecommendListDataAngleList.purpose = purpose;
  }
  final int? onlineStatus = jsonConvert.convert<int>(json['onlineStatus']);
  if (onlineStatus != null) {
    querySeekRecommendListDataAngleList.onlineStatus = onlineStatus;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    querySeekRecommendListDataAngleList.sex = sex;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    querySeekRecommendListDataAngleList.description = description;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    querySeekRecommendListDataAngleList.userId = userId;
  }
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    querySeekRecommendListDataAngleList.uid = uid;
  }
  final dynamic personality = json['personality'];
  if (personality != null) {
    querySeekRecommendListDataAngleList.personality = personality;
  }
  final dynamic interest = json['interest'];
  if (interest != null) {
    querySeekRecommendListDataAngleList.interest = interest;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    querySeekRecommendListDataAngleList.appId = appId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    querySeekRecommendListDataAngleList.nickname = nickname;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    querySeekRecommendListDataAngleList.age = age;
  }
  final List<String>? covers = (json['covers'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (covers != null) {
    querySeekRecommendListDataAngleList.covers = covers;
  }
  return querySeekRecommendListDataAngleList;
}

Map<String, dynamic> $QuerySeekRecommendListDataAngleListToJson(
    QuerySeekRecommendListDataAngleList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['birthday'] = entity.birthday;
  data['headImg'] = entity.headImg;
  data['distance'] = entity.distance;
  data['purpose'] = entity.purpose;
  data['onlineStatus'] = entity.onlineStatus;
  data['sex'] = entity.sex;
  data['description'] = entity.description;
  data['userId'] = entity.userId;
  data['uid'] = entity.uid;
  data['personality'] = entity.personality;
  data['interest'] = entity.interest;
  data['appId'] = entity.appId;
  data['nickname'] = entity.nickname;
  data['age'] = entity.age;
  data['covers'] = entity.covers;
  return data;
}

extension QuerySeekRecommendListDataAngleListExtension on QuerySeekRecommendListDataAngleList {
  QuerySeekRecommendListDataAngleList copyWith({
    String? birthday,
    String? headImg,
    double? distance,
    dynamic purpose,
    int? onlineStatus,
    int? sex,
    String? description,
    String? userId,
    int? uid,
    dynamic personality,
    dynamic interest,
    String? appId,
    String? nickname,
    int? age,
    List<String>? covers,
  }) {
    return QuerySeekRecommendListDataAngleList()
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