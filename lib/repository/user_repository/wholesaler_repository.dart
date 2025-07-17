import 'package:b2b_exchange_development_version/features/wholesaler/models/wholesaler_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WholesalerRepository extends GetxController {
  static WholesalerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // -- Storing data
  createWholesaler(WholesalerModel wholesaler) async {
    await _db
        .collection("Wholesalers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(wholesaler.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "User Authentication has been successfull but was not added into databse.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // fetch wholesaler details
  Future<WholesalerModel> getWholesalerDetails(String email) async {
    final snapshot = await _db
        .collection("Wholesalers")
        .where("Email", isEqualTo: email)
        .get();

    final wholesalerData =
        snapshot.docs.map((e) => WholesalerModel.fromSnapshot(e)).single;
    return wholesalerData;
  }

  // fetch all wholesalers
  Future<List<WholesalerModel>> allWholesalers() async {
    final snapshot = await _db.collection("Wholesalers").get();

    final wholesalerData =
        snapshot.docs.map((e) => WholesalerModel.fromSnapshot(e)).toList();
    return wholesalerData;
  }

  Future<void> updateWholesalerRecord(WholesalerModel wholesaler) async {
    await _db
        .collection("Wholesalers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(wholesaler.toJson())
        .whenComplete(
          () {
            Get.snackbar(
                "Success", "Your account has been Edited Successfully.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green);
            print("Profile Updated");

          })
        .catchError((error, stackTrace) {
      Get.snackbar("Error",
          "Something went wrong please check wholesaler repository file.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });

  }
}
