import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';

BaseEntity $BaseEntityFromJson(Map<String, dynamic> json) {
  final BaseEntity baseEntity = BaseEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    baseEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    baseEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    baseEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    baseEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    baseEntity.message = message;
  }
  return baseEntity;
}

Map<String, dynamic> $BaseEntityToJson(BaseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension BaseEntityExtension on BaseEntity {
  BaseEntity copyWith({
    int? code,
    dynamic data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return BaseEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}