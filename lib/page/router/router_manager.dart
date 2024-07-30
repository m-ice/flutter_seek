import 'package:flutter_d0601/controller/controller_bindings/login_binding.dart';
import 'package:flutter_d0601/controller/controller_bindings/personal_basicInformation_bindings.dart';
import 'package:flutter_d0601/controller/controller_bindings/personal_info_index_binding.dart';
import 'package:flutter_d0601/controller/controller_bindings/setting_binding.dart';
import 'package:flutter_d0601/controller/controller_bindings/view_images_bindings.dart';
import 'package:flutter_d0601/page/home/my/about/about_page.dart';
import 'package:flutter_d0601/page/home/my/money/vip_of_open_or_details_page.dart';
import 'package:flutter_d0601/page/home/my/setting/setting_page.dart';
import 'package:flutter_d0601/page/home/sed/personal_info_index/personal_info_index_page.dart';
import 'package:flutter_d0601/page/login/login_page.dart';
import 'package:flutter_d0601/page/login/phone_login/phone_verification_code/phone_verification_code_page.dart';
import 'package:get/get.dart';
import '../../controller/controller_bindings/edit_profile_binding.dart';
import '../../controller/controller_bindings/home_binding.dart';
import '../../controller/controller_bindings/phone_login_bindings.dart';
import '../../controller/controller_bindings/splash_binding.dart';
import '../../controller/controller_bindings/user_agreement_or_privacy_policy_binding.dart';
import '../../controller/controller_bindings/vip_of_open_or_details_binding.dart';
import '../home/discover/chat/chat_message_page.dart';
import '../home/discover/view_images/view_images_page.dart';
import '../home/home_page.dart';
import '../home/my/edit_profile/edit_profile_page.dart';
import '../home/my/edit_profile/set_personal_info_item/set_personal_info_item_page.dart';
import '../home/sed/set_person_basic_information/personal_basic_information_page.dart';
import '../login/phone_login/choose_country/choose_country_page.dart';
import '../login/phone_login/phone_login_page.dart';
import '../login/user_agreement_or_privacy_policy/user_agreement_or_privacy_policy_page.dart';
import '../middleware/chat_message_middleware.dart';
import '../splash_page.dart';

class RouterManager{
  /// 首页
  static const String home='/';
  /// 闪屏页
  static const String splash='/splash';
  /// 登录
  static const String login='/login';
  /// 手机号登录
  static const String phoneLogin='/phoneLogin';
  /// 选择手机号所在城市
  static const String chooseCountry='/chooseCountry';
  /// 输入手机验证码
  static const String phoneVerificationCode='/phoneVerificationCode';
  /// 个人基础信息页
  static const String personalBasicInformation='/personBasicInformation';
  /// 编辑个人信息
  static const String editProfile='/editProfile';
  /// 设置页面
  static const String setting='/setting';
  /// 关于
  static const String aboutPage='/aboutPage';
  /// 个人主页
  static const String personalInfoIndex='/personalInfoIndex';
  /// 开通vip或vip 详情
  static const String vipOfOpenOrDetails='/vipOfOpenOrDetails';
  /// 聊天消息页面
  static const String chatMessagePage='/chatMessagePage';
  /// 无中间件  聊天消息页面
  static const String chatMessagePageMiddlewareFree='/chatMessagePageMiddlewareFree';
  /// 查看图片
  static const String viewImagesPage='/viewImagesPage';
  /// 设置用户信息
  static const String setPersonalInfoItemPage='/setPersonalInfoItemPage';
  /// 隐私协议 用户协议
  static const String userAgreementOrPrivacyPolicyPage='/userAgreementOrPrivacyPolicyPage';


  /// 路由列表
  static final routerList=[
    GetPage(name: splash, page: ()=>const SplashPage(),bindings: [SplashBinding()],transition: Transition.fadeIn),
    GetPage(name: home, page: ()=>const HomePage(),transition: Transition.fadeIn,binding: HomeBinding(),children: [
      GetPage(name: login, page: ()=>const LoginPage(),transition: Transition.fadeIn,bindings: [
        LoginBinding(),PersonalBasicInformationBindings()]),
      GetPage(name: userAgreementOrPrivacyPolicyPage, page: ()=> const UserAgreementOrPrivacyPolicyPage(),binding: UserAgreementOrPrivacyPolicyBinding()),
      GetPage(name: phoneLogin, page: ()=>const PhoneLoginPage(),bindings: [
        PhoneLoginBinding(),PersonalBasicInformationBindings()]),
      GetPage(name: chooseCountry, page: ()=>const ChooseCountryPage()),
      GetPage(name: phoneVerificationCode, page: ()=>const PhoneVerificationCodePage()),
      GetPage(name: editProfile, page: ()=>const EditProfilePage(),bindings: [
        EditProfileBinding(),
        PersonalBasicInformationBindings()
      ]),
      GetPage(name: setting, page: ()=>const SettingPage(),binding: SettingBinding()),
      GetPage(name: aboutPage, page: ()=>const AboutPage()),
      GetPage(name: vipOfOpenOrDetails, page: ()=>const VipOfOpenOrDetailsPage(),binding: VipOfOpenOrDetailsBinding()),
      GetPage(name: chatMessagePage, page: ()=>const ChatMessagePage(),middlewares: [
        ChatMessageMiddleware(),
      ]),
      GetPage(name: chatMessagePageMiddlewareFree, page: ()=>const ChatMessagePage()),
      GetPage(name: personalInfoIndex, page: ()=>const PersonalInfoIndexPage(),binding: PersonalInfoIndexBinding()),
      GetPage(name: personalBasicInformation, page: ()=>const PersonalBasicInformationPage(),
          binding: PersonalBasicInformationBindings(),transition: Transition.size),
      GetPage(name: viewImagesPage, page: ()=>const ViewImagesPage(),binding: ViewImagesBinding()),
      GetPage(name: setPersonalInfoItemPage, page: ()=>const SetPersonalInfoItemPage(),),
    ]),
  ];
}

// fade: 页面渐变动画，新页面会从透明度为 0 的状态渐变到完全显示。
//
// fadeIn: 渐入动画，新页面会从透明度为 0 的状态渐变到完全显示。
//
// rightToLeft: 从右向左滑动动画，新页面从屏幕右侧滑入显示。
//
// leftToRight: 从左向右滑动动画，新页面从屏幕左侧滑入显示。
//
// upToDown: 从上到下滑动动画，新页面从屏幕顶部滑入显示。
//
// downToUp: 从下到上滑动动画，新页面从屏幕底部滑入显示。
//
// rightToLeftWithFade: 从右向左滑动并渐变动画。
//
// leftToRightWithFade: 从左向右滑动并渐变动画。
//
// zoom: 缩放动画，新页面从小到大缩放显示。
//
// topLevel: 顶层动画，新页面从顶部覆盖到当前页面。
//
// noTransition: 无动画，直接切换页面，没有过渡效果。
//
// cupertino: iOS 风格的切换动画。
//
// cupertinoDialog: iOS 风格的对话框切换动画。
//
// size: 大小变化动画，新页面从小到大放大显示。
//
// circularReveal: 圆形揭示动画。
//
// native: 原生平台的切换动画。