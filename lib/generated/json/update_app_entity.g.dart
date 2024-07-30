import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/model/update_app_entity.dart';

UpdateAppEntity $UpdateAppEntityFromJson(Map<String, dynamic> json) {
  final UpdateAppEntity updateAppEntity = UpdateAppEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    updateAppEntity.code = code;
  }
  final List<UpdateAppData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<UpdateAppData>(e) as UpdateAppData)
      .toList();
  if (data != null) {
    updateAppEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    updateAppEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    updateAppEntity.requestId = requestId;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    updateAppEntity.count = count;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateAppEntity.message = message;
  }
  return updateAppEntity;
}

Map<String, dynamic> $UpdateAppEntityToJson(UpdateAppEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['count'] = entity.count;
  data['message'] = entity.message;
  return data;
}

extension UpdateAppEntityExtension on UpdateAppEntity {
  UpdateAppEntity copyWith({
    int? code,
    List<UpdateAppData>? data,
    bool? success,
    dynamic requestId,
    int? count,
    String? message,
  }) {
    return UpdateAppEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..count = count ?? this.count
      ..message = message ?? this.message;
  }
}

UpdateAppData $UpdateAppDataFromJson(Map<String, dynamic> json) {
  final UpdateAppData updateAppData = UpdateAppData();
  final dynamic owner = json['owner'];
  if (owner != null) {
    updateAppData.owner = owner;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    updateAppData.productId = productId;
  }
  final String? gmtModify = jsonConvert.convert<String>(json['gmtModify']);
  if (gmtModify != null) {
    updateAppData.gmtModify = gmtModify;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    updateAppData.sort = sort;
  }
  final int? cityId = jsonConvert.convert<int>(json['cityId']);
  if (cityId != null) {
    updateAppData.cityId = cityId;
  }
  final String? gmtCreate = jsonConvert.convert<String>(json['gmtCreate']);
  if (gmtCreate != null) {
    updateAppData.gmtCreate = gmtCreate;
  }
  final int? parentId = jsonConvert.convert<int>(json['parentId']);
  if (parentId != null) {
    updateAppData.parentId = parentId;
  }
  final int? biz = jsonConvert.convert<int>(json['biz']);
  if (biz != null) {
    updateAppData.biz = biz;
  }
  final bool? enable = jsonConvert.convert<bool>(json['enable']);
  if (enable != null) {
    updateAppData.enable = enable;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    updateAppData.appId = appId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    updateAppData.name = name;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    updateAppData.startTime = startTime;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateAppData.id = id;
  }
  final String? endTime = jsonConvert.convert<String>(json['endTime']);
  if (endTime != null) {
    updateAppData.endTime = endTime;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    updateAppData.value = value;
  }
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    updateAppData.key = key;
  }
  final int? classType = jsonConvert.convert<int>(json['classType']);
  if (classType != null) {
    updateAppData.classType = classType;
  }
  return updateAppData;
}

Map<String, dynamic> $UpdateAppDataToJson(UpdateAppData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['owner'] = entity.owner;
  data['productId'] = entity.productId;
  data['gmtModify'] = entity.gmtModify;
  data['sort'] = entity.sort;
  data['cityId'] = entity.cityId;
  data['gmtCreate'] = entity.gmtCreate;
  data['parentId'] = entity.parentId;
  data['biz'] = entity.biz;
  data['enable'] = entity.enable;
  data['appId'] = entity.appId;
  data['name'] = entity.name;
  data['startTime'] = entity.startTime;
  data['id'] = entity.id;
  data['endTime'] = entity.endTime;
  data['value'] = entity.value;
  data['key'] = entity.key;
  data['classType'] = entity.classType;
  return data;
}

extension UpdateAppDataExtension on UpdateAppData {
  UpdateAppData copyWith({
    dynamic owner,
    int? productId,
    String? gmtModify,
    int? sort,
    int? cityId,
    String? gmtCreate,
    int? parentId,
    int? biz,
    bool? enable,
    String? appId,
    String? name,
    String? startTime,
    int? id,
    String? endTime,
    String? value,
    String? key,
    int? classType,
  }) {
    return UpdateAppData()
      ..owner = owner ?? this.owner
      ..productId = productId ?? this.productId
      ..gmtModify = gmtModify ?? this.gmtModify
      ..sort = sort ?? this.sort
      ..cityId = cityId ?? this.cityId
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..parentId = parentId ?? this.parentId
      ..biz = biz ?? this.biz
      ..enable = enable ?? this.enable
      ..appId = appId ?? this.appId
      ..name = name ?? this.name
      ..startTime = startTime ?? this.startTime
      ..id = id ?? this.id
      ..endTime = endTime ?? this.endTime
      ..value = value ?? this.value
      ..key = key ?? this.key
      ..classType = classType ?? this.classType;
  }
}