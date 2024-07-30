import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/money_config_entity.dart';

MoneyConfigEntity $MoneyConfigEntityFromJson(Map<String, dynamic> json) {
  final MoneyConfigEntity moneyConfigEntity = MoneyConfigEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    moneyConfigEntity.code = code;
  }
  final List<MoneyConfigData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MoneyConfigData>(e) as MoneyConfigData)
      .toList();
  if (data != null) {
    moneyConfigEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    moneyConfigEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    moneyConfigEntity.requestId = requestId;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    moneyConfigEntity.count = count;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    moneyConfigEntity.message = message;
  }
  return moneyConfigEntity;
}

Map<String, dynamic> $MoneyConfigEntityToJson(MoneyConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['count'] = entity.count;
  data['message'] = entity.message;
  return data;
}

extension MoneyConfigEntityExtension on MoneyConfigEntity {
  MoneyConfigEntity copyWith({
    int? code,
    List<MoneyConfigData>? data,
    bool? success,
    dynamic requestId,
    int? count,
    String? message,
  }) {
    return MoneyConfigEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..count = count ?? this.count
      ..message = message ?? this.message;
  }
}

MoneyConfigData $MoneyConfigDataFromJson(Map<String, dynamic> json) {
  final MoneyConfigData moneyConfigData = MoneyConfigData();
  final int? itemType = jsonConvert.convert<int>(json['itemType']);
  if (itemType != null) {
    moneyConfigData.itemType = itemType;
  }
  final String? gmtModify = jsonConvert.convert<String>(json['gmtModify']);
  if (gmtModify != null) {
    moneyConfigData.gmtModify = gmtModify;
  }
  final int? channel = jsonConvert.convert<int>(json['channel']);
  if (channel != null) {
    moneyConfigData.channel = channel;
  }
  final dynamic origPrice = json['origPrice'];
  if (origPrice != null) {
    moneyConfigData.origPrice = origPrice;
  }
  final dynamic discount = json['discount'];
  if (discount != null) {
    moneyConfigData.discount = discount;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    moneyConfigData.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    moneyConfigData.title = title;
  }
  final dynamic itemOrigCount = json['itemOrigCount'];
  if (itemOrigCount != null) {
    moneyConfigData.itemOrigCount = itemOrigCount;
  }
  final bool? enable = jsonConvert.convert<bool>(json['enable']);
  if (enable != null) {
    moneyConfigData.enable = enable;
  }
  final String? configId = jsonConvert.convert<String>(json['configId']);
  if (configId != null) {
    moneyConfigData.configId = configId;
  }
  final double? price = jsonConvert.convert<double>(json['price']);
  if (price != null) {
    moneyConfigData.price = price;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    moneyConfigData.appId = appId;
  }
  final int? showType = jsonConvert.convert<int>(json['showType']);
  if (showType != null) {
    moneyConfigData.showType = showType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    moneyConfigData.id = id;
  }
  final int? awardValue = jsonConvert.convert<int>(json['awardValue']);
  if (awardValue != null) {
    moneyConfigData.awardValue = awardValue;
  }
  final dynamic charge = json['charge'];
  if (charge != null) {
    moneyConfigData.charge = charge;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    moneyConfigData.productId = productId;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    moneyConfigData.sort = sort;
  }
  final String? gmtCreate = jsonConvert.convert<String>(json['gmtCreate']);
  if (gmtCreate != null) {
    moneyConfigData.gmtCreate = gmtCreate;
  }
  final int? itemCount = jsonConvert.convert<int>(json['itemCount']);
  if (itemCount != null) {
    moneyConfigData.itemCount = itemCount;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    moneyConfigData.name = name;
  }
  final int? abVersion = jsonConvert.convert<int>(json['abVersion']);
  if (abVersion != null) {
    moneyConfigData.abVersion = abVersion;
  }
  final int? subType = jsonConvert.convert<int>(json['subType']);
  if (subType != null) {
    moneyConfigData.subType = subType;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    moneyConfigData.desc = desc;
  }
  final int? awardType = jsonConvert.convert<int>(json['awardType']);
  if (awardType != null) {
    moneyConfigData.awardType = awardType;
  }
  return moneyConfigData;
}

Map<String, dynamic> $MoneyConfigDataToJson(MoneyConfigData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['itemType'] = entity.itemType;
  data['gmtModify'] = entity.gmtModify;
  data['channel'] = entity.channel;
  data['origPrice'] = entity.origPrice;
  data['discount'] = entity.discount;
  data['type'] = entity.type;
  data['title'] = entity.title;
  data['itemOrigCount'] = entity.itemOrigCount;
  data['enable'] = entity.enable;
  data['configId'] = entity.configId;
  data['price'] = entity.price;
  data['appId'] = entity.appId;
  data['showType'] = entity.showType;
  data['id'] = entity.id;
  data['awardValue'] = entity.awardValue;
  data['charge'] = entity.charge;
  data['productId'] = entity.productId;
  data['sort'] = entity.sort;
  data['gmtCreate'] = entity.gmtCreate;
  data['itemCount'] = entity.itemCount;
  data['name'] = entity.name;
  data['abVersion'] = entity.abVersion;
  data['subType'] = entity.subType;
  data['desc'] = entity.desc;
  data['awardType'] = entity.awardType;
  return data;
}

extension MoneyConfigDataExtension on MoneyConfigData {
  MoneyConfigData copyWith({
    int? itemType,
    String? gmtModify,
    int? channel,
    dynamic origPrice,
    dynamic discount,
    int? type,
    String? title,
    dynamic itemOrigCount,
    bool? enable,
    String? configId,
    double? price,
    String? appId,
    int? showType,
    int? id,
    int? awardValue,
    dynamic charge,
    int? productId,
    int? sort,
    String? gmtCreate,
    int? itemCount,
    String? name,
    int? abVersion,
    int? subType,
    String? desc,
    int? awardType,
  }) {
    return MoneyConfigData()
      ..itemType = itemType ?? this.itemType
      ..gmtModify = gmtModify ?? this.gmtModify
      ..channel = channel ?? this.channel
      ..origPrice = origPrice ?? this.origPrice
      ..discount = discount ?? this.discount
      ..type = type ?? this.type
      ..title = title ?? this.title
      ..itemOrigCount = itemOrigCount ?? this.itemOrigCount
      ..enable = enable ?? this.enable
      ..configId = configId ?? this.configId
      ..price = price ?? this.price
      ..appId = appId ?? this.appId
      ..showType = showType ?? this.showType
      ..id = id ?? this.id
      ..awardValue = awardValue ?? this.awardValue
      ..charge = charge ?? this.charge
      ..productId = productId ?? this.productId
      ..sort = sort ?? this.sort
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..itemCount = itemCount ?? this.itemCount
      ..name = name ?? this.name
      ..abVersion = abVersion ?? this.abVersion
      ..subType = subType ?? this.subType
      ..desc = desc ?? this.desc
      ..awardType = awardType ?? this.awardType;
  }
}