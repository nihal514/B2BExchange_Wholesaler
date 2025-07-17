import 'package:b2b_exchange_development_version/repository/authentication_repository/wholesaler_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WLoginController extends GetxController {
  static WLoginController get instance => Get.find();

  var isLoading = false.obs;
  //Textfield controller to get the data from Textfeilds
  final email = TextEditingController();
  final password = TextEditingController();

  //Call this Function from Design & it will do the rest
  Future<void> loginWholesaler(String email, String password) async {
    isLoading.value = true;
    String? error = await WAuthenticationRepository.instance
        .wLoginWithEmailAndPassword(email, password);
    isLoading.value = false;
    if (error != null) {
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    } else {
      Get.snackbar("Success :", "You are logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.green);
    }
  }

  Future<void> loginWholesalerWithGoogle()async {

    String? error = await WAuthenticationRepository.instance.wSignInWithGoogle();
    if (error != null)
    {
      Get.snackbar("Error :",error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
    else
    {
      Get.snackbar("Success :", "You are logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.green);
    }
  }
}
