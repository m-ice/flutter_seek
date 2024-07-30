import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/sed/model/query_seek_likes_visitors_entity.dart';

QuerySeekLikesVisitorsEntity $QuerySeekLikesVisitorsEntityFromJson(
    Map<String, dynamic> json) {
  final QuerySeekLikesVisitorsEntity querySeekLikesVisitorsEntity = QuerySeekLikesVisitorsEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    querySeekLikesVisitorsEntity.code = code;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    querySeekLikesVisitorsEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    querySeekLikesVisitorsEntity.requestId = requestId;
  }
  final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
  if (hasMore != null) {
    querySeekLikesVisitorsEntity.hasMore = hasMore;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    querySeekLikesVisitorsEntity.pageSize = pageSize;
  }
  final int? page = jsonConvert.convert<int>(json['page']);
  if (page != null) {
    querySeekLikesVisitorsEntity.page = page;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    querySeekLikesVisitorsEntity.totalCount = totalCount;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    querySeekLikesVisitorsEntity.message = message;
  }
  final List<QuerySeekLikesVisitorsItems>? items = (json['items'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QuerySeekLikesVisitorsItems>(
          e) as QuerySeekLikesVisitorsItems).toList();
  if (items != null) {
    querySeekLikesVisitorsEntity.items = items;
  }
  return querySeekLikesVisitorsEntity;
}

Map<String, dynamic> $QuerySeekLikesVisitorsEntityToJson(
    QuerySeekLikesVisitorsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['hasMore'] = entity.hasMore;
  data['pageSize'] = entity.pageSize;
  data['page'] = entity.page;
  data['totalCount'] = entity.totalCount;
  data['message'] = entity.message;
  data['items'] = entity.items?.map((v) => v.toJson()).toList();
  return data;
}

extension QuerySeekLikesVisitorsEntityExtension on QuerySeekLikesVisitorsEntity {
  QuerySeekLikesVisitorsEntity copyWith({
    int? code,
    bool? success,
    dynamic requestId,
    bool? hasMore,
    int? pageSize,
    int? page,
    int? totalCount,
    String? message,
    List<QuerySeekLikesVisitorsItems>? items,
  }) {
    return QuerySeekLikesVisitorsEntity()
      ..code = code ?? this.code
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..hasMore = hasMore ?? this.hasMore
      ..pageSize = pageSize ?? this.pageSize
      ..page = page ?? this.page
      ..totalCount = totalCount ?? this.totalCount
      ..message = message ?? this.message
      ..items = items ?? this.items;
  }
}

QuerySeekLikesVisitorsItems $QuerySeekLikesVisitorsItemsFromJson(
    Map<String, dynamic> json) {
  final QuerySeekLikesVisitorsItems querySeekLikesVisitorsItems = QuerySeekLikesVisitorsItems();
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    querySeekLikesVisitorsItems.birthday = birthday;
  }
  final String? headImg = jsonConvert.convert<String>(json['headImg']);
  if (headImg != null) {
    querySeekLikesVisitorsItems.headImg = headImg;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    querySeekLikesVisitorsItems.distance = distance;
  }
  final dynamic purpose = json['purpose'];
  if (purpose != null) {
    querySeekLikesVisitorsItems.purpose = purpose;
  }
  final int? onlineStatus = jsonConvert.convert<int>(json['onlineStatus']);
  if (onlineStatus != null) {
    querySeekLikesVisitorsItems.onlineStatus = onlineStatus;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    querySeekLikesVisitorsItems.sex = sex;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    querySeekLikesVisitorsItems.description = description;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    querySeekLikesVisitorsItems.userId = userId;
  }
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    querySeekLikesVisitorsItems.uid = uid;
  }
  final dynamic personality = json['personality'];
  if (personality != null) {
    querySeekLikesVisitorsItems.personality = personality;
  }
  final dynamic interest = json['interest'];
  if (interest != null) {
    querySeekLikesVisitorsItems.interest = interest;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    querySeekLikesVisitorsItems.appId = appId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    querySeekLikesVisitorsItems.nickname = nickname;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    querySeekLikesVisitorsItems.age = age;
  }
  final List<String>? covers = (json['covers'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (covers != null) {
    querySeekLikesVisitorsItems.covers = covers;
  }
  return querySeekLikesVisitorsItems;
}

Map<String, dynamic> $QuerySeekLikesVisitorsItemsToJson(
    QuerySeekLikesVisitorsItems entity) {
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

extension QuerySeekLikesVisitorsItemsExtension on QuerySeekLikesVisitorsItems {
  QuerySeekLikesVisitorsItems copyWith({
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
    return QuerySeekLikesVisitorsItems()
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