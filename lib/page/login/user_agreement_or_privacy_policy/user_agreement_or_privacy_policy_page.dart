import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_base_config/cus_behavior.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/user_agreement_or_privacy_policy_controller.dart';
import 'package:flutter_d0601/page/widgets/appbar_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

import '../../widgets/custom_loader_overlay_widget.dart';

import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAgreementOrPrivacyPolicyPage extends  StatefulWidget{
   const UserAgreementOrPrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<UserAgreementOrPrivacyPolicyPage> createState() => _UserAgreementOrPrivacyPolicyPageState();
}

class _UserAgreementOrPrivacyPolicyPageState extends State<UserAgreementOrPrivacyPolicyPage> {
   UserAgreementOrPrivacyPolicyController agreementOrPrivacyPolicyController=Get.find<UserAgreementOrPrivacyPolicyController>();
   final GlobalKey webViewKey = GlobalKey();

   InAppWebViewController? webViewController;
   InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
       crossPlatform: InAppWebViewOptions(
         useShouldOverrideUrlLoading: true,
         mediaPlaybackRequiresUserGesture: false,
       ),
       android: AndroidInAppWebViewOptions(
         useHybridComposition: true,
       ),
       ios: IOSInAppWebViewOptions(
         allowsInlineMediaPlayback: true,
       ));

   late PullToRefreshController pullToRefreshController;

   @override
   void initState() {
     super.initState();

     pullToRefreshController = PullToRefreshController(
       options: PullToRefreshOptions(
         color: Colors.blue,
       ),
       onRefresh: () async {
         if (Platform.isAndroid) {
           webViewController?.reload();
         } else if (Platform.isIOS) {
           webViewController?.loadUrl(
               urlRequest: URLRequest(url: await webViewController?.getUrl()));
         }
       },
     );
   }

   @override
   void dispose() {
     super.dispose();
   }

   @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAgreementOrPrivacyPolicyController>(
      init: agreementOrPrivacyPolicyController,
      builder: (privacyPolicyController) {
        return Scaffold(
          appBar: getAppBarWidget(context: context,title:  privacyPolicyController.title,),
          body: CustomLoaderOverlayWidget(
            // progressValue: controller.onProgress*1.0,
            loading:  privacyPolicyController.onProgress <1.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child:

            ScrollConfiguration(
              behavior: CusBehavior(),
              child:    SafeArea(
                  child: Column(children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            key: webViewKey,
                            initialUrlRequest:
                            URLRequest(url: Uri.parse(
                              privacyPolicyController.url??(privacyPolicyController.userPrivacyKey=='user'?
                              Constants.userAgreement:Constants.privacyAgreement),)),
                            initialOptions: options,
                            pullToRefreshController: pullToRefreshController,
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              privacyPolicyController..url = url.toString()..update();
                            },
                            androidOnPermissionRequest: (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action: PermissionRequestResponseAction.GRANT);
                            },
                            shouldOverrideUrlLoading: (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;

                              if (![ "http", "https", "file", "chrome",
                                "data", "javascript", "about"].contains(uri.scheme)) {
                                if (await canLaunchUrl(Uri.parse(privacyPolicyController.url??''))) {
                                  // Launch the App
                                  await launchUrl(
                                    Uri.parse(privacyPolicyController.url??''),
                                  );
                                  // and cancel the request
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStop: (controller, url) async {
                              pullToRefreshController.endRefreshing();
                              privacyPolicyController..url = url.toString()..update();
                            },
                            onLoadError: (controller, url, code, message) {
                              pullToRefreshController.endRefreshing();
                            },
                            onProgressChanged: (controller, progress) {
                              if (progress == 100) {
                                pullToRefreshController.endRefreshing();
                              }
                              setState(() {
                                privacyPolicyController..onProgress = (progress/100)..update() ;
                              });
                            },
                            onUpdateVisitedHistory: (controller, url, androidIsReload) {
                              privacyPolicyController..url = url.toString()..update();
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              debugPrint("控制台消息${consoleMessage.toJson().toString()}");
                            },
                          ),
                          privacyPolicyController.onProgress < 1.0
                              ? LinearProgressIndicator(value: privacyPolicyController.onProgress)
                              : Container(),
                        ],
                      ),
                    ),
                    // ButtonBar(
                    //   alignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     ElevatedButton(
                    //       child: Icon(Icons.arrow_back,size: 28.setWidth(),),
                    //       onPressed: () {
                    //         webViewController?.goBack();
                    //       },
                    //     ),
                    //     ElevatedButton(
                    //       child: Icon(Icons.arrow_forward,size: 28.setWidth()),
                    //       onPressed: () {
                    //         webViewController?.goForward();
                    //       },
                    //     ),
                    //     ElevatedButton(
                    //       child: Icon(Icons.refresh,size: 28.setWidth()),
                    //       onPressed: () {
                    //         webViewController?.reload();
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ])),
              // WebView(
              //   backgroundColor: Colors.white,
              //   initialUrl: controller.url??(controller.userPrivacyKey=='user'?Constants.userAgreement:Constants.privacyAgreement),
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onProgress: (v){
              //     controller..onProgress=v..update();
              //   },
              // ),
            )
          ),
          )
        );
      }
    );
  }

// SingleChildScrollView(
//   child: Padding(
//     padding: EdgeInsets.symmetric(horizontal: 10.setWidth()),
//     child: Html(
//       data: controller.connectMap[controller.userPrivacyKey],
//     ),
//   ),
// ),
}
