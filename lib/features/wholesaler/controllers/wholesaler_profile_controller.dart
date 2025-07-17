import 'dart:io';

import 'package:b2b_exchange_development_version/features/wholesaler/models/wholesaler_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b2b_exchange_development_version/repository/authentication_repository/wholesaler_authentication_repository.dart';
import 'package:b2b_exchange_development_version/repository/user_repository/wholesaler_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class WProfileController extends GetxController {
  static WProfileController get instance => Get.find();

  //Repositories
  final _authRepo = Get.put(WAuthenticationRepository());
  final _WholesalerRepo = Get.put(WholesalerRepository());
  var isLoading = false.obs;
  var wImage=null;
  var imageChanged=false.obs;
  var imageLink=null;

  // Get Wholesaler email and pass to WholesalerRepository to fetch Wholesaler record.
  getWholesalerData() {
    final email = _authRepo.firebaseUser.value?.email;

    if (email != null) {
      return _WholesalerRepo.getWholesalerDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  //fetch list of Wholesaler records
  Future<List<WholesalerModel>> getAllWholesalers() async => await _WholesalerRepo.allWholesalers();

  updateRecord(WholesalerModel Wholesaler) async {

    await _WholesalerRepo.updateWholesalerRecord(Wholesaler);

  }

  pickWholesalerImage() async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
       imageChanged.value = false;
        return;
      }
      else {
        imageChanged.value = false;
        wImage = File(img.path);
        imageChanged.value = true;
      }
    } catch (e) {
      imageChanged.value = false;
      Get.snackbar("Error :",e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  uploadWholesalerImage() async{
      if(wImage!=null){

        var filename = basename(wImage.path);
        var destination = 'images/vendors/${FirebaseAuth.instance.currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(wImage);
        imageLink = await ref.getDownloadURL();

      }
  }



}
