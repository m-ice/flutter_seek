import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/discover/model/chat_message_entity.dart';

ChatMessageEntity $ChatMessageEntityFromJson(Map<String, dynamic> json) {
  final ChatMessageEntity chatMessageEntity = ChatMessageEntity();
  final String? senderId = jsonConvert.convert<String>(json['senderId']);
  if (senderId != null) {
    chatMessageEntity.senderId = senderId;
  }
  final String? senderUid = jsonConvert.convert<String>(json['senderUid']);
  if (senderUid != null) {
    chatMessageEntity.senderUid = senderUid;
  }
  final String? senderAppId = jsonConvert.convert<String>(json['senderAppId']);
  if (senderAppId != null) {
    chatMessageEntity.senderAppId = senderAppId;
  }
  final String? receiveId = jsonConvert.convert<String>(json['receiveId']);
  if (receiveId != null) {
    chatMessageEntity.receiveId = receiveId;
  }
  final String? receiveUid = jsonConvert.convert<String>(json['receiveUid']);
  if (receiveUid != null) {
    chatMessageEntity.receiveUid = receiveUid;
  }
  final int? messageId = jsonConvert.convert<int>(json['messageId']);
  if (messageId != null) {
    chatMessageEntity.messageId = messageId;
  }
  final int? messageType = jsonConvert.convert<int>(json['messageType']);
  if (messageType != null) {
    chatMessageEntity.messageType = messageType;
  }
  final int? unRead = jsonConvert.convert<int>(json['unRead']);
  if (unRead != null) {
    chatMessageEntity.unRead = unRead;
  }
  final String? senderHeadImg = jsonConvert.convert<String>(
      json['senderHeadImg']);
  if (senderHeadImg != null) {
    chatMessageEntity.senderHeadImg = senderHeadImg;
  }
  final String? senderNickName = jsonConvert.convert<String>(
      json['senderNickName']);
  if (senderNickName != null) {
    chatMessageEntity.senderNickName = senderNickName;
  }
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    chatMessageEntity.extra = extra;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    chatMessageEntity.content = content;
  }
  final int? sentTime = jsonConvert.convert<int>(json['sentTime']);
  if (sentTime != null) {
    chatMessageEntity.sentTime = sentTime;
  }
  return chatMessageEntity;
}

Map<String, dynamic> $ChatMessageEntityToJson(ChatMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['senderId'] = entity.senderId;
  data['senderUid'] = entity.senderUid;
  data['senderAppId'] = entity.senderAppId;
  data['receiveId'] = entity.receiveId;
  data['receiveUid'] = entity.receiveUid;
  data['messageId'] = entity.messageId;
  data['messageType'] = entity.messageType;
  data['unRead'] = entity.unRead;
  data['senderHeadImg'] = entity.senderHeadImg;
  data['senderNickName'] = entity.senderNickName;
  data['extra'] = entity.extra;
  data['content'] = entity.content;
  data['sentTime'] = entity.sentTime;
  return data;
}

extension ChatMessageEntityExtension on ChatMessageEntity {
  ChatMessageEntity copyWith({
    String? senderId,
    String? senderUid,
    String? senderAppId,
    String? receiveId,
    String? receiveUid,
    int? messageId,
    int? messageType,
    int? unRead,
    String? senderHeadImg,
    String? senderNickName,
    String? extra,
    String? content,
    int? sentTime,
  }) {
    return ChatMessageEntity()
      ..senderId = senderId ?? this.senderId
      ..senderUid = senderUid ?? this.senderUid
      ..senderAppId = senderAppId ?? this.senderAppId
      ..receiveId = receiveId ?? this.receiveId
      ..receiveUid = receiveUid ?? this.receiveUid
      ..messageId = messageId ?? this.messageId
      ..messageType = messageType ?? this.messageType
      ..unRead = unRead ?? this.unRead
      ..senderHeadImg = senderHeadImg ?? this.senderHeadImg
      ..senderNickName = senderNickName ?? this.senderNickName
      ..extra = extra ?? this.extra
      ..content = content ?? this.content
      ..sentTime = sentTime ?? this.sentTime;
  }
}