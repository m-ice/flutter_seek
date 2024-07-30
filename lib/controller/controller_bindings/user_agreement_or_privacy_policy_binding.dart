

import 'package:get/get.dart';

import '../user_agreement_or_privacy_policy_controller.dart';

class UserAgreementOrPrivacyPolicyBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<UserAgreementOrPrivacyPolicyController>(() => UserAgreementOrPrivacyPolicyController());
  }


}