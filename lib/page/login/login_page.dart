import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/app_colors.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/controller/login_controller.dart';
import 'package:flutter_d0601/enum/login_type_enum.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/back_ground_widget.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController=Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: loginController,
      builder: (controller) {
        return Scaffold(
            body: BackGroundWidget(
              backGroundName: "login_bg",
              unpackMasking: true,
              // gradient: RadialGradient(colors: const [Color(0x661A031E),Color(0x6611031E)],
              //   focalRadius: 180.setRadius(),
              //   // begin: Alignment.bottomCenter,end: Alignment.topCenter,
              //   // stops: [0.3,0.5]
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
                      child: ImageWidget(url: ResourceUtil.getAppPageIcon("start1"), width: 72.setWidth(), height: 72.setWidth())),
                  Padding(
                      padding: EdgeInsets.only(top: 8.setHeight()),
                      child: ImageWidget(url: ResourceUtil.getAppPageIcon("start2"),color: Colors.white, width: 68.setWidth(), height: 24.setWidth())),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 36.setHeight(),horizontal: 24.setWidth()),
                    child: Column(
                      children: [
                        definitionLoginButton(title: "Sign in with Google",iconPath: 'google',onTap: (){
                          controller.loginSubmit(loginTypeEnum: LoginTypeEnum.google);
                        }),
                        Padding(
                          padding: EdgeInsets.only(top: 16.setHeight()),
                          child: definitionLoginButton(title: "Sign in with Phone",iconPath: 'iphone',onTap: (){
                            controller.loginSubmit(loginTypeEnum: LoginTypeEnum.phone);
                          }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: (24+MediaQuery.of(context).padding.bottom).setHeight()),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ParentInkWellWidget(
                          onTap: controller.setAgreementConsent,
                          child: Container(
                            height: 20.setWidth(),
                            width: 20.setWidth(),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ResourceUtil.getAppPageIcon('login_check')),
                                fit: BoxFit.cover
                              ),
                            ),
                            child: controller.agreementConsent?ImageWidget(url: ResourceUtil.getAppPageIcon('login_check_1'),width: 10.18.setWidth(),):const SizedBox(),
                          ),
                          // Container(
                          //     margin: EdgeInsets.only(right: 1.67.setWidth()),
                          //     child: ShaderMask(
                          //       child: Icon(controller.agreementConsent?Icons.check_circle_rounded:Icons.radio_button_unchecked_rounded,size: 20.setWidth(),color: Colors.white,),
                          //       shaderCallback: (bounds) => const RadialGradient(
                          //           center: Alignment.topLeft,
                          //           radius: 1.0,
                          //           colors: [AppColors.maskColor1,AppColors.maskColor2,AppColors.maskColor3],
                          //           tileMode: TileMode.mirror
                          //       ).createShader(bounds),
                          //     ),
                          //     // ImageWidget(
                          //     //   url: ResourceUtil.getAppPageIcon("choose_fill"),
                          //     //   width: 20.setWidth(),
                          //     //   height: 20.setWidth(),
                          //     // ),
                          // ),
                        ),
                        Text.rich(
                          TextSpan(
                              text: "By continuting you agree to the",
                              style: getFontStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing:0.1
                              ),
                              children:  [
                                TextSpan(
                                    text: "\nUser Agreement",
                                    style: getFontStyle(
                                        color: const Color(0xFF8E48FF),
                                        fontSize: 12,
                                        letterSpacing:0.1
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap=(){
                                      Get.toNamed("${RouterManager.userAgreementOrPrivacyPolicyPage}?title=User Agreement&&userPrivacyKey=user");
                                    }
                                ),
                                const TextSpan(
                                    text: " & "
                                ),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style: getFontStyle(
                                        color: const Color(0xFF8E48FF),
                                        fontSize: 12,
                                        letterSpacing:0.1
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap=(){
                                      Get.toNamed("${RouterManager.userAgreementOrPrivacyPolicyPage}?title=Privacy Policy&&userPrivacyKey=privacy");
                                    }
                                ),
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      }
    );
  }

  /// 登录按钮
  definitionLoginButton({required String title,required Function onTap,required String iconPath}){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          onTap.call();
        },
        borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 20.setWidth(),vertical: 13.setHeight()),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                url: ResourceUtil.getAppPageIcon(iconPath),
                height: 18.setHeight(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(title,style: getFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,letterSpacing: 0.2
                  ),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

