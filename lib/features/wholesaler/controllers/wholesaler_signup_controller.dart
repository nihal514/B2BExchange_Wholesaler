import 'package:b2b_exchange_development_version/features/wholesaler/models/wholesaler_model.dart';
import 'package:b2b_exchange_development_version/repository/authentication_repository/wholesaler_authentication_repository.dart';
import 'package:b2b_exchange_development_version/repository/user_repository/wholesaler_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WSignUpController extends GetxController {
  static WSignUpController get instance => Get.find();

  var isLoading = false.obs;

//TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

//Call this Function from Design & it will do the rest
//   Future<void> registerWholesaler(String email, String password) async{
//     String? error =await AuthenticationRepository.instance.createWholesalerWithEmailAndPassword(email, password);
//     if (error != null)
//       {
//         Get.snackbar("Error :",error.toString(),
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.redAccent.withOpacity(0.1),
//             colorText: Colors.red);
//       }
//     else
//       {
//
//       }
//   }

  //Call this Function from Design & it will do the rest

  Future<void> registerWholesaler(WholesalerModel wholesaler) async {
    isLoading.value = true;
    String? error = await WAuthenticationRepository.instance
        .createWholesalerWithEmailAndPassword(
            wholesaler.email, wholesaler.password);
    if (error != null) {
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      isLoading.value = false;
    } else {
      createWholesaler(wholesaler);
    }
  }

  // Get phoneNo from wholesaler and pass it to Auth Repository for firebase Authentication
  void phoneAuthentication(String phoneNo) {
    WAuthenticationRepository.instance.wPhoneAuthentication(phoneNo);
  }

  //creating wholesaler storing wholesalers data in database
  final wholesalerRepo = Get.put(WholesalerRepository());

  Future<void> createWholesaler(WholesalerModel wholesaler) async {
    await wholesalerRepo.createWholesaler(wholesaler);
    isLoading.value = false;
    // do work after creation of wholesaler

    // for email and password authentication
    // registerWholesaler(wholesaler.email,wholesaler.password);

    // for phone authentication
    // phoneAuthentication(wholesaler.phoneNo);
    // Get.to(() => const OTPScreen());
  }

  Future<void> registerWholesalerWithGoogle() async {
    String? error =
        await WAuthenticationRepository.instance.wSignInWithGoogle();
    if (error != null) {
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    } else {
      final wholesaler = WholesalerModel(
          email: FirebaseAuth.instance.currentUser!.email!,
          password: "Amanshaikh123#\$",
          fullName: FirebaseAuth.instance.currentUser!.displayName!);
      createWholesaler(wholesaler);
    }
  }
}
