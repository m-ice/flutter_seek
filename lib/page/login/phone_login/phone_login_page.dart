import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/app_style/input_text_restrict.dart';
import 'package:flutter_d0601/controller/phone_login_controller.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/back_ground_widget.dart';
import 'package:flutter_d0601/page/widgets/button_ink_well_widget.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_d0601/utils/toast_util.dart';
import 'package:get/get.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  FocusNode focusNode=FocusNode();
  String phoneNumber="";
  final phoneLoginController=Get.find<PhoneLoginController>();
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onPanDown: ((v){
        if(focusNode.hasFocus){
          setState(() {
            focusNode.unfocus();
          });
        }
      }),
      child: Scaffold(
        body: BackGroundWidget(
          backGroundName: "bg_1",
          unpackBack: true,
          child: GetBuilder<PhoneLoginController>(
            init: phoneLoginController,
            builder: (controller){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 24.setWidth(),),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("What’s your phone number?",style: getFontStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                        Padding(padding: EdgeInsets.only(top: 12.setHeight(),),
                          child: Text("We’ll send you a verification code",style: getFontStyle(fontSize: 14,fontWeight: FontWeight.w400,fontHeight: 1.4),),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.setHeight()),
                          child: TextField(
                            focusNode: focusNode,
                            // cursorColor: const Color(0xFFF5F5F5),
                            onChanged: (v){
                              setState(() {
                                phoneNumber=v;
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(InputTextRestrict.regexOnlyNumber),
                              )
                            ],
                            decoration: InputDecoration(
                                hintText: "Please enter",
                                helperStyle: getFontStyle(
                                    fontSize: 16,
                                    color: const Color(0xFF9E9E9E),
                                    fontHeight: 1.4,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w500
                                ),
                                filled: true,
                                // fillColor: const Color(0xFFF5F5F5),
                                // cursorColor: const Color(0xFFF5F5F5),
                                fillColor: const Color(0xFF000000).withOpacity(0.04),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.setRadius()),
                                    ),
                                    borderSide: const BorderSide(style: BorderStyle.none)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.setRadius()),
                                    ),
                                    borderSide: const BorderSide(style: BorderStyle.none)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.setRadius()),
                                    ),
                                    borderSide: const BorderSide(style: BorderStyle.none)
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: (){
                                    Get.toNamed(RouterManager.chooseCountry);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 12.setWidth()),
                                    padding: EdgeInsets.only(top: 12.setHeight(),bottom: 12.setHeight(),left: 12.setWidth(),right: 6.setWidth()),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  [
                                        ImageWidget(url:
                                        ResourceUtil.getCountryIcon(controller.countryList[controller.changeCurrentIndex].iconName),
                                            width: 24.setWidth(), height: 24.setWidth()),
                                        Text("+${controller.countryList[controller.changeCurrentIndex].headPhoneNumber}",style: getFontStyle(fontSize: 16,fontWeight: FontWeight.w700,fontHeight: 1.4,letterSpacing: 0.2),),
                                        const Icon(Icons.arrow_drop_down_outlined,color: Colors.black,),
                                      ],
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(top: 24.setHeight(),bottom:24.setHeight(),left: 24.setWidth()),
                                hintStyle: getFontStyle(fontHeight: 1.4,color: const Color(0xFF9E9E9E),fontWeight: FontWeight.w500,fontSize: 16,letterSpacing: 0.2)
                            ),
                          ),
                        ),
                        ButtonInkWellWidget(
                          changeColor: GetUtils.isPhoneNumber(phoneNumber),
                          title: "Continue",
                          onTap: (){
                            if(phoneNumber.trim().isNotEmpty){
                              if(GetUtils.isPhoneNumber(phoneNumber)){
                                controller..phoneNumber=phoneNumber..update();
                                controller.requestVerificationCode();
                              }else{
                                toast('Invalid mobile phone number');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
