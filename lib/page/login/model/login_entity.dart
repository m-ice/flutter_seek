import 'package:flutter_d0601/generated/json/base/json_field.dart';
import 'package:flutter_d0601/generated/json/login_entity.g.dart';
import 'dart:convert';
export 'package:flutter_d0601/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
	int? code;
	LoginData? data;
	bool? success;
	dynamic requestId;
	String? message;

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginData {
	dynamic outRole;
	LoginDataUserInfo? userInfo;
	dynamic needGuide;
	String? token;
	dynamic svipBound;

	LoginData();

	factory LoginData.fromJson(Map<String, dynamic> json) => $LoginDataFromJson(json);

	Map<String, dynamic> toJson() => $LoginDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginDataUserInfo {
	dynamic charmLevel;
	int? channel;
	String? source;
	int? cityId;
	bool? empty;
	String? vsId;
	dynamic advertAaid;
	dynamic initBasicInfoBySystem;
	String? appId;
	List<dynamic>? pris;
	String? appKey;
	int? id;
	double? lat;
	String? area;
	String? headImg;
	double? lng;
	int? productId;
	dynamic level;
	dynamic invitation;
	String? extendInfo;
	String? authInfo;
	dynamic privatePhotoUrl;
	String? name;
	String? campaign;
	LoginDataUserInfoAbResult? abResult;
	int? displayId;
	String? device;
	int? status;
	String? birthday;
	String? gmtLastLogin;
	LoginDataUserInfoFunctionAuth? functionAuth;
	String? role;
	String? gmtModify;
	int? albumNum;
	String? multiLang;
	dynamic specialId;
	String? cityName;
	String? countryCode;
	String? nickname;
	dynamic privateVideoUrl;
	String? lang;
	int? secretNum;
	String? email;
	int? sex;
	String? mobile;
	String? gmtCreate;
	dynamic tagUrlList;
	String? userId;
	dynamic newUser;
	dynamic invitationH5;
	int? isRegister;

	LoginDataUserInfo();

	factory LoginDataUserInfo.fromJson(Map<String, dynamic> json) => $LoginDataUserInfoFromJson(json);

	Map<String, dynamic> toJson() => $LoginDataUserInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginDataUserInfoAbResult {


	LoginDataUserInfoAbResult();

	factory LoginDataUserInfoAbResult.fromJson(Map<String, dynamic> json) => $LoginDataUserInfoAbResultFromJson(json);

	Map<String, dynamic> toJson() => $LoginDataUserInfoAbResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginDataUserInfoFunctionAuth {
	dynamic enableMatchBot;
	dynamic enableBuyVip;
	dynamic enableMsgBot;
	bool? enableScreenshot;
	dynamic putInUser;
	dynamic enableFourthPay;
	dynamic enableUseVoiceRoom;
	dynamic enableRoomTab;
	dynamic naturalUser;

	LoginDataUserInfoFunctionAuth();

	factory LoginDataUserInfoFunctionAuth.fromJson(Map<String, dynamic> json) => $LoginDataUserInfoFunctionAuthFromJson(json);

	Map<String, dynamic> toJson() => $LoginDataUserInfoFunctionAuthToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}