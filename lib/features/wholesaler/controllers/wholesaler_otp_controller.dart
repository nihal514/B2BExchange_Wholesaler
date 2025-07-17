
import 'package:b2b_exchange_development_version/repository/authentication_repository/wholesaler_authentication_repository.dart';
import 'package:get/get.dart';

import '../screens/wholesaler_home/wholesaler_home_screen.dart';

class WOTPController extends GetxController {
  static WOTPController get instance => Get.find();

  //this function should be called from otp_screen
  void verifyOTP(String otp) async {
    var isVerified = await WAuthenticationRepository.instance.wVerifyOTP(otp);
    isVerified ? Get.offAll(const WholesalerHomeScreen()) : Get.back();
  }


}