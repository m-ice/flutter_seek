import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/discover/model/other_data_entity.dart';

OtherDataEntity $OtherDataEntityFromJson(Map<String, dynamic> json) {
  final OtherDataEntity otherDataEntity = OtherDataEntity();
  final String? landerUID = jsonConvert.convert<String>(json['landerUID']);
  if (landerUID != null) {
    otherDataEntity.landerUID = landerUID;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    otherDataEntity.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    otherDataEntity.userId = userId;
  }
  final int? saveTime = jsonConvert.convert<int>(json['saveTime']);
  if (saveTime != null) {
    otherDataEntity.saveTime = saveTime;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    otherDataEntity.type = type;
  }
  return otherDataEntity;
}

Map<String, dynamic> $OtherDataEntityToJson(OtherDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['landerUID'] = entity.landerUID;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  data['saveTime'] = entity.saveTime;
  data['type'] = entity.type;
  return data;
}

extension OtherDataEntityExtension on OtherDataEntity {
  OtherDataEntity copyWith({
    String? landerUID,
    String? uid,
    String? userId,
    int? saveTime,
    int? type,
  }) {
    return OtherDataEntity()
      ..landerUID = landerUID ?? this.landerUID
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId
      ..saveTime = saveTime ?? this.saveTime
      ..type = type ?? this.type;
  }
}