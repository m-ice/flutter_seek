import 'package:flutter_d0601/http/api_url.dart';
import '../generated/json/base/json_convert_content.dart';
import 'dio_util.dart';

class DioService<T> {
  T? model;

  // todo <-----------------------------------------用户模块 start------------------------------------------------->
  /// 登录注册
  thirdAuth(dynamic data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.thirdAuth,module: 'user',pathTmp: 'u', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 刷新token
  refreshToken(dynamic data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.refreshToken,module: 'user',pathTmp: 'u', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 发送验证码
  sendMessage(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.sendMessage,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 修改用户信息
  updateUser(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.updateUser,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 相册添加修改
  albumUpdate(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.albumUpdate,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询普通相册列表
  albumList(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.albumList,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询供选择的AI标签
  listUserAiTagEnums(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.listUserAiTagEnums,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询个人用户详情
  queryUser(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.queryUser,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询个人AI标签
  queryUserAiTag(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.queryUserAiTag,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 更新AI标签
  updateUserAiTag(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.updateUserAiTag,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 获取用户详情
  queryUserVsid(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.queryUserVsid,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 举报用户
  reportUser(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.reportUser,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 拉黑/取消拉黑
  blockUser(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.blockUser,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  ///  删除账号
  deleteAccount(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.deleteAccount,pathTmp: 'u',module: 'user', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------用户模块 end------------------------------------------------->

  // todo <-----------------------------------------主播列表 start------------------------------------------------->
  /// 查询主播个人主页信息
  querySeekAngleInfo(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.querySeekAngleInfo,pathTmp: 'a',module: 'vivalive-anchor', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// querySeekLikesVisitors-likes/visitors列表
  querySeekLikesVisitors(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.querySeekLikesVisitors,pathTmp: 'a',module: 'vivalive-anchor', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 首页查询推荐列表
  querySeekRecommendList(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.querySeekRecommendList,pathTmp: 'a',module: 'vivalive-anchor', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------主播列表 end------------------------------------------------->

  // todo <-----------------------------------------配置 start------------------------------------------------->
  /// 获取资源上传配置
  upload(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.upload,pathTmp: 'ms',module: 'vivalive-ms', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询货币配置
  moneyConfig(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.moneyConfig,pathTmp: 'ms',module: 'vivalive-ms', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 版本审核开关
  auditSwitch(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.auditSwitch,pathTmp: 'ms',module: 'vivalive-ms', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  ///  配置查询
  config(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.config,pathTmp: 'ms',module: 'vivalive-ms', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------配置 end------------------------------------------------->

  // todo <-----------------------------------------账户 start------------------------------------------------->
  /// 查询账户详情
  getUserAccountDetail(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.getUserAccountDetail,pathTmp: 'ac',module: 'vivalive-account', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------账户 end------------------------------------------------->

  // todo <-----------------------------------------活动 start------------------------------------------------->
  /// app端事件通知接口
  appEventInform(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.appEventInform,pathTmp: 'acti',module: 'vivalive-activity', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------活动 end------------------------------------------------->

  // todo <-----------------------------------------订单 start------------------------------------------------->
  /// 获取支付方式配置
  queryAppPayChannel(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.queryAppPayChannel,pathTmp: 'o',module: 'vivalive-order', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 查询用户前后置充值标识
  queryPayConfigExt(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.queryPayConfigExt,pathTmp: 'o',module: 'vivalive-order', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  /// 充值
  recharge(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.recharge,pathTmp: 'o',module: 'vivalive-order', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------订单 end------------------------------------------------->

  // todo <-----------------------------------------im start------------------------------------------------->
  /// 添加融云用户
  addImUser(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.addImUser,pathTmp: 'video.message.MessageService',module: 'vivalive-message', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------im end------------------------------------------------->


  // todo <-----------------------------------------chat start------------------------------------------------->
  /// aiTalk-IM对话
  aiTalk(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.aiTalk,pathTmp: 'acti',module: 'vivalive-activity', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }

  /// quickReplyMessages-快捷回复消息列表
  quickReplyMessages(data) async {
    Map<String, dynamic>? map = await DioUtil.getInstance()
        .httpUtil
        .post<T>(ApiUrl.quickReplyMessages,pathTmp: 'acti',module: 'vivalive-activity', data: data);
    model = JsonConvert.fromJsonAsT<T>(map);
    return model;
  }
  // todo <-----------------------------------------chat end------------------------------------------------->
}
