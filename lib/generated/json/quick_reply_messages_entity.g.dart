import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/discover/model/quick_reply_messages_entity.dart';

QuickReplyMessagesEntity $QuickReplyMessagesEntityFromJson(
    Map<String, dynamic> json) {
  final QuickReplyMessagesEntity quickReplyMessagesEntity = QuickReplyMessagesEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    quickReplyMessagesEntity.code = code;
  }
  final List<QuickReplyMessagesData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<QuickReplyMessagesData>(e) as QuickReplyMessagesData)
      .toList();
  if (data != null) {
    quickReplyMessagesEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    quickReplyMessagesEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    quickReplyMessagesEntity.requestId = requestId;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    quickReplyMessagesEntity.count = count;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    quickReplyMessagesEntity.message = message;
  }
  return quickReplyMessagesEntity;
}

Map<String, dynamic> $QuickReplyMessagesEntityToJson(
    QuickReplyMessagesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['count'] = entity.count;
  data['message'] = entity.message;
  return data;
}

extension QuickReplyMessagesEntityExtension on QuickReplyMessagesEntity {
  QuickReplyMessagesEntity copyWith({
    int? code,
    List<QuickReplyMessagesData>? data,
    bool? success,
    dynamic requestId,
    int? count,
    String? message,
  }) {
    return QuickReplyMessagesEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..count = count ?? this.count
      ..message = message ?? this.message;
  }
}

QuickReplyMessagesData $QuickReplyMessagesDataFromJson(
    Map<String, dynamic> json) {
  final QuickReplyMessagesData quickReplyMessagesData = QuickReplyMessagesData();
  final String? msgContent = jsonConvert.convert<String>(json['msgContent']);
  if (msgContent != null) {
    quickReplyMessagesData.msgContent = msgContent;
  }
  return quickReplyMessagesData;
}

Map<String, dynamic> $QuickReplyMessagesDataToJson(
    QuickReplyMessagesData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgContent'] = entity.msgContent;
  return data;
}

extension QuickReplyMessagesDataExtension on QuickReplyMessagesData {
  QuickReplyMessagesData copyWith({
    String? msgContent,
  }) {
    return QuickReplyMessagesData()
      ..msgContent = msgContent ?? this.msgContent;
  }
}