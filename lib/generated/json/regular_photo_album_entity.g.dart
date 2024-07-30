import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/regular_photo_album_entity.dart';

RegularPhotoAlbumEntity $RegularPhotoAlbumEntityFromJson(
    Map<String, dynamic> json) {
  final RegularPhotoAlbumEntity regularPhotoAlbumEntity = RegularPhotoAlbumEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    regularPhotoAlbumEntity.code = code;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    regularPhotoAlbumEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    regularPhotoAlbumEntity.requestId = requestId;
  }
  final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
  if (hasMore != null) {
    regularPhotoAlbumEntity.hasMore = hasMore;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    regularPhotoAlbumEntity.pageSize = pageSize;
  }
  final int? page = jsonConvert.convert<int>(json['page']);
  if (page != null) {
    regularPhotoAlbumEntity.page = page;
  }
  final int? totalCount = jsonConvert.convert<int>(json['totalCount']);
  if (totalCount != null) {
    regularPhotoAlbumEntity.totalCount = totalCount;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    regularPhotoAlbumEntity.message = message;
  }
  final List<RegularPhotoAlbumItems>? items = (json['items'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<RegularPhotoAlbumItems>(e) as RegularPhotoAlbumItems)
      .toList();
  if (items != null) {
    regularPhotoAlbumEntity.items = items;
  }
  return regularPhotoAlbumEntity;
}

Map<String, dynamic> $RegularPhotoAlbumEntityToJson(
    RegularPhotoAlbumEntity entity) {
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

extension RegularPhotoAlbumEntityExtension on RegularPhotoAlbumEntity {
  RegularPhotoAlbumEntity copyWith({
    int? code,
    bool? success,
    dynamic requestId,
    bool? hasMore,
    int? pageSize,
    int? page,
    int? totalCount,
    String? message,
    List<RegularPhotoAlbumItems>? items,
  }) {
    return RegularPhotoAlbumEntity()
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

RegularPhotoAlbumItems $RegularPhotoAlbumItemsFromJson(
    Map<String, dynamic> json) {
  final RegularPhotoAlbumItems regularPhotoAlbumItems = RegularPhotoAlbumItems();
  final dynamic gmtCreate = json['gmt_create'];
  if (gmtCreate != null) {
    regularPhotoAlbumItems.gmtCreate = gmtCreate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    regularPhotoAlbumItems.address = address;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    regularPhotoAlbumItems.appId = appId;
  }
  final dynamic gmtModify = json['gmt_modify'];
  if (gmtModify != null) {
    regularPhotoAlbumItems.gmtModify = gmtModify;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    regularPhotoAlbumItems.sort = sort;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    regularPhotoAlbumItems.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    regularPhotoAlbumItems.title = title;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    regularPhotoAlbumItems.userId = userId;
  }
  final String? operator = jsonConvert.convert<String>(json['operator']);
  if (operator != null) {
    regularPhotoAlbumItems.operator = operator;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    regularPhotoAlbumItems.status = status;
  }
  final int? haveFace = jsonConvert.convert<int>(json['haveFace']);
  if (haveFace != null) {
    regularPhotoAlbumItems.haveFace = haveFace;
  }
  return regularPhotoAlbumItems;
}

Map<String, dynamic> $RegularPhotoAlbumItemsToJson(
    RegularPhotoAlbumItems entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['gmt_create'] = entity.gmtCreate;
  data['address'] = entity.address;
  data['appId'] = entity.appId;
  data['gmt_modify'] = entity.gmtModify;
  data['sort'] = entity.sort;
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['userId'] = entity.userId;
  data['operator'] = entity.operator;
  data['status'] = entity.status;
  data['haveFace'] = entity.haveFace;
  return data;
}

extension RegularPhotoAlbumItemsExtension on RegularPhotoAlbumItems {
  RegularPhotoAlbumItems copyWith({
    dynamic gmtCreate,
    String? address,
    String? appId,
    dynamic gmtModify,
    int? sort,
    int? id,
    String? title,
    String? userId,
    String? operator,
    int? status,
    int? haveFace,
  }) {
    return RegularPhotoAlbumItems()
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..address = address ?? this.address
      ..appId = appId ?? this.appId
      ..gmtModify = gmtModify ?? this.gmtModify
      ..sort = sort ?? this.sort
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..userId = userId ?? this.userId
      ..operator = operator ?? this.operator
      ..status = status ?? this.status
      ..haveFace = haveFace ?? this.haveFace;
  }
}