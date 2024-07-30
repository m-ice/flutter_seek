import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/sed/model/sliding_record_entity.dart';

SlidingRecordEntity $SlidingRecordEntityFromJson(Map<String, dynamic> json) {
  final SlidingRecordEntity slidingRecordEntity = SlidingRecordEntity();
  final int? numberOfSlips = jsonConvert.convert<int>(json['numberOfSlips']);
  if (numberOfSlips != null) {
    slidingRecordEntity.numberOfSlips = numberOfSlips;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    slidingRecordEntity.userId = userId;
  }
  final String? saveTime = jsonConvert.convert<String>(json['saveTime']);
  if (saveTime != null) {
    slidingRecordEntity.saveTime = saveTime;
  }
  return slidingRecordEntity;
}

Map<String, dynamic> $SlidingRecordEntityToJson(SlidingRecordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['numberOfSlips'] = entity.numberOfSlips;
  data['userId'] = entity.userId;
  data['saveTime'] = entity.saveTime;
  return data;
}

extension SlidingRecordEntityExtension on SlidingRecordEntity {
  SlidingRecordEntity copyWith({
    int? numberOfSlips,
    String? userId,
    String? saveTime,
  }) {
    return SlidingRecordEntity()
      ..numberOfSlips = numberOfSlips ?? this.numberOfSlips
      ..userId = userId ?? this.userId
      ..saveTime = saveTime ?? this.saveTime;
  }
}