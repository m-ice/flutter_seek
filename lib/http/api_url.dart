
class ApiUrl{
  // todo module:user  用户 start
  /// 登录注册
  static const String thirdAuth='thirdAuth';
  /// 刷新token
  static const String refreshToken='refreshToken';
  /// 发送验证码
  static const String sendMessage='sendMessage';
  /// 修改用户信息
  static const String updateUser='updateUser';
  /// 相册添加修改
  static const String albumUpdate='albumUpdate';
  /// 查询普通相册列表
  static const String albumList='albumList';
  /// 查询私密相册列表
  static const String albumPrivateList='albumPrivateList';
  /// 查询个人用户详情
  static const String queryUser='queryUser';
  /// 获取他人用户详情
  static const String queryUserOthers='queryUserOthers';
  /// 查询供选择的AI标签
  static const String listUserAiTagEnums ='listUserAiTagEnums';
  /// 查询个人AI标签
  static const String queryUserAiTag ='queryUserAiTag';
  /// 更新AI标签
  static const String updateUserAiTag='updateUserAiTag';
  /// 获取用户详情
  static const String queryUserVsid='queryUserVsid';
  ///  举报用户
  static const String reportUser='reportUser';
  /// 拉黑/取消拉黑
  static const String blockUser='blockUser';
  /// 删除账号
  static const String deleteAccount='deleteAccount';
  // todo module:user end


  // todo module:vivalive-anchor  主播列表 start
  /// 查询主播个人主页信息
  static const String querySeekAngleInfo='querySeekAngleInfo';
  /// querySeekLikesVisitors-likes/visitors列表
  static const String querySeekLikesVisitors='querySeekLikesVisitors';
  /// 首页查询推荐列表
  static const String querySeekRecommendList='querySeekRecommendList';
  // todo module:vivalive-anchor 主播列表 end


  // todo 	module:vivalive-ms  配置 start
  /// 获取资源上传配置
  static const String upload='upload';
  /// 查询货币配置
  static const String moneyConfig='moneyConfig';
  ///  版本审核开关
  static const String auditSwitch='auditSwitch';
  ///  配置查询
  static const String config='config';
  // todo module:vivalive-ms 配置 end


  // todo module:vivalive-account appId:v.ac. 账户 start
  /// 查询账户详情
  static const String getUserAccountDetail='getUserAccountDetail';
  // todo module:vivalive-account 账户 end

  // todo module:vivalive-activity appId:	v.acti. 活动 start
  /// app端事件通知接口
  static const String appEventInform='appEventInform';
  // todo module:	vivalive-activity 活动 end


  // todo module:	vivalive-order appId:	v.o. 订单 start
  /// 获取支付方式配置
  static const String queryAppPayChannel='queryAppPayChannel';
  /// 查询用户前后置充值标识
  static const String queryPayConfigExt='queryPayConfigExt';
  /// 充值
  static const String recharge='recharge';
  // todo module:	vivalive-order 订单 end

  // todo module:vivalive-message appId:v.video.message.MessageService im start
  /// 添加融云用户
  static const String addImUser='addImUser';
  // todo module:vivalive-message im end

  // todo module:vivalive-activity appId:v.acti. chat start
  /// aiTalk-IM对话
  static const String aiTalk='aiTalk';
  /// quickReplyMessages-快捷回复消息列表
  static const String quickReplyMessages='quickReplyMessages';

  // todo module:vivalive-activity chat end

}
