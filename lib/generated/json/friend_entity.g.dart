import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/discover/model/friend_entity.dart';

FriendEntity $FriendEntityFromJson(Map<String, dynamic> json) {
  final FriendEntity friendEntity = FriendEntity();
  final String? landerUID = jsonConvert.convert<String>(json['landerUID']);
  if (landerUID != null) {
    friendEntity.landerUID = landerUID;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    friendEntity.message = message;
  }
  final String? targetId = jsonConvert.convert<String>(json['targetId']);
  if (targetId != null) {
    friendEntity.targetId = targetId;
  }
  final int? messageType = jsonConvert.convert<int>(json['messageType']);
  if (messageType != null) {
    friendEntity.messageType = messageType;
  }
  final int? conversationType = jsonConvert.convert<int>(
      json['conversationType']);
  if (conversationType != null) {
    friendEntity.conversationType = conversationType;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    friendEntity.userId = userId;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    friendEntity.appId = appId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    friendEntity.nickname = nickname;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    friendEntity.portrait = portrait;
  }
  final String? alias = jsonConvert.convert<String>(json['alias']);
  if (alias != null) {
    friendEntity.alias = alias;
  }
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    friendEntity.extra = extra;
  }
  final int? receivedTime = jsonConvert.convert<int>(json['receivedTime']);
  if (receivedTime != null) {
    friendEntity.receivedTime = receivedTime;
  }
  final int? sentTime = jsonConvert.convert<int>(json['sentTime']);
  if (sentTime != null) {
    friendEntity.sentTime = sentTime;
  }
  final int? unreadCount = jsonConvert.convert<int>(json['unreadCount']);
  if (unreadCount != null) {
    friendEntity.unreadCount = unreadCount;
  }
  final int? offLine = jsonConvert.convert<int>(json['offLine']);
  if (offLine != null) {
    friendEntity.offLine = offLine;
  }
  final int? top = jsonConvert.convert<int>(json['top']);
  if (top != null) {
    friendEntity.top = top;
  }
  return friendEntity;
}

Map<String, dynamic> $FriendEntityToJson(FriendEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['landerUID'] = entity.landerUID;
  data['message'] = entity.message;
  data['targetId'] = entity.targetId;
  data['messageType'] = entity.messageType;
  data['conversationType'] = entity.conversationType;
  data['userId'] = entity.userId;
  data['appId'] = entity.appId;
  data['nickname'] = entity.nickname;
  data['portrait'] = entity.portrait;
  data['alias'] = entity.alias;
  data['extra'] = entity.extra;
  data['receivedTime'] = entity.receivedTime;
  data['sentTime'] = entity.sentTime;
  data['unreadCount'] = entity.unreadCount;
  data['offLine'] = entity.offLine;
  data['top'] = entity.top;
  return data;
}

extension FriendEntityExtension on FriendEntity {
  FriendEntity copyWith({
    String? landerUID,
    String? message,
    String? targetId,
    int? messageType,
    int? conversationType,
    String? userId,
    String? appId,
    String? nickname,
    String? portrait,
    String? alias,
    String? extra,
    int? receivedTime,
    int? sentTime,
    int? unreadCount,
    int? offLine,
    int? top,
  }) {
    return FriendEntity()
      ..landerUID = landerUID ?? this.landerUID
      ..message = message ?? this.message
      ..targetId = targetId ?? this.targetId
      ..messageType = messageType ?? this.messageType
      ..conversationType = conversationType ?? this.conversationType
      ..userId = userId ?? this.userId
      ..appId = appId ?? this.appId
      ..nickname = nickname ?? this.nickname
      ..portrait = portrait ?? this.portrait
      ..alias = alias ?? this.alias
      ..extra = extra ?? this.extra
      ..receivedTime = receivedTime ?? this.receivedTime
      ..sentTime = sentTime ?? this.sentTime
      ..unreadCount = unreadCount ?? this.unreadCount
      ..offLine = offLine ?? this.offLine
      ..top = top ?? this.top;
  }
}