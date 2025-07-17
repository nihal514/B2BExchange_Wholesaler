import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/controllers/wholesaler_shop_setting_controller.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WShopSetting extends StatelessWidget {
  const WShopSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopSettingController());
    return Obx(()=>Scaffold(
        appBar: WAppBarWidget("Wholesaler Shop Setting"),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.shopNameController,
                        decoration: const InputDecoration(
                            label: Text("Shop Name"),
                            prefixIcon: Icon(Icons.store)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopAddressController,
                        decoration: const InputDecoration(
                            label: Text("Shop Address"),
                            prefixIcon: Icon(Icons.location_on_outlined)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopMobileController,
                        decoration: const InputDecoration(
                            label: Text("Shop Mobile"),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopWebsiteController,
                        decoration: const InputDecoration(
                            label: Text("Shop Website"),
                            prefixIcon: Icon(Icons.laptop_chromebook_rounded)),
                      ),
                      const SizedBox(height: myFormHeight - 20),
                      TextFormField(
                        controller: controller.shopDescriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                            label: Text("Shop Description"),
                            prefixIcon: Icon(Icons.description)),
                      ),
                      const SizedBox(height: myFormHeight - 10),
                      SizedBox(
                        width: double.infinity,
                        child: controller.isLoading.value ? Center(child: SizedBox(width:35.0,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)))) : ElevatedButton(
                          onPressed: () async {
                            await controller.updateShop(
                              shopName: controller.shopNameController.text,
                              shopAddress: controller.shopAddressController.text,
                              shopMobile: controller.shopMobileController.text,
                              shopWebsite: controller.shopWebsiteController.text,
                              shopDescription: controller.shopDescriptionController.text
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: myPrimaryColor,
                              shape: const StadiumBorder(),
                              side: BorderSide.none,
                              foregroundColor: Colors.black),
                          child: Text("Save".toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
