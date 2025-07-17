import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/controllers/wholesaler_products_controller.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_appbar_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_products/wholesaler_product_dropdown.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_products/wholesaler_product_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class WAddProduct extends StatelessWidget {
  const WAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    var tapped=[false.obs,false.obs,false.obs,false.obs,false.obs,false.obs,false.obs,false.obs,false.obs,false.obs];
    return Obx(()=>Scaffold(
          appBar: WAppBarWidget("Wholesaler Add Product"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.pNameController,
                      decoration: const InputDecoration(
                          label: Text("Product Name"),
                          prefixIcon: Icon(LineAwesomeIcons.t_shirt)),
                    ),
                    const SizedBox(height: myFormHeight - 20),
                    TextFormField(
                      controller: controller.pDescController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          label: Text("Product Description"),
                          prefixIcon: Icon(Icons.description)),
                    ),
                    const SizedBox(height: myFormHeight - 20),
                    TextFormField(
                      controller: controller.pPriceController,
                      decoration: const InputDecoration(
                          label: Text("Price"),
                          prefixIcon: Icon(Icons.attach_money_outlined)),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: myFormHeight - 20),
                    TextFormField(
                      controller: controller.pQuantityController,
                      decoration: const InputDecoration(
                          label: Text("Quantity"),
                          prefixIcon:
                              Icon(Icons.production_quantity_limits_outlined)),
                        keyboardType: TextInputType.number
                    ),
                    const SizedBox(height: myFormHeight - 20),
                    WProductDropdown("Choose Category", controller.categoryList,
                        controller.categoryvalue, controller),
                    const SizedBox(height: myFormHeight - 20),
                    WProductDropdown(
                        "Choose Subcategory",
                        controller.subcategoryList,
                        controller.subcategoryvalue,
                        controller),
                    const Divider(),
                    const SizedBox(height: myFormHeight - 20),
                    Text("Choose product images",
                        style: const TextStyle(
                            color: lightGrey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: myFormHeight - 20),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            3,
                            (index) => controller.pImagesList[index] != null
                                ? Image.file(
                                    controller.pImagesList[index],
                                    width: 100,
                                  ).onTap(() {controller.pickImage(index, context);})
                                : WProductImages(
                                    label: "${index + 1}",
                                  ).onTap(() {
                                    controller.pickImage(index, context);
                                  })),
                      ),
                    ),
                    const SizedBox(height: myFormHeight - 20),
                    Text("First image will be your display image",
                        style: const TextStyle(color: lightGrey)),
                    const Divider(),
                    const SizedBox(height: myFormHeight - 20),
                    Text("Choose product color",
                        style: const TextStyle(
                            color: lightGrey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: myFormHeight - 10),
                     Obx(()=> Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                                10,
                                (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .color(Color(controller.commonClothsColors[index]))
                                            .roundedFull
                                            .size(60, 60)
                                            .make()
                                            .onTap(() {
                                          if(tapped[index].value==true)
                                            {
                                              tapped[index].value=false;
                                              controller.selectedColors.removeAt(index);
                                            }
                                          else{
                                            tapped[index].value=true;
                                            controller.selectedColors.add(controller.commonClothsColors[index]);
                                          }
                                        }),
                                        tapped[index].value
                                            ? const Icon(
                                                Icons.done,
                                                color: myWhiteColor,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ))),
                     ),

                    const SizedBox(height: myFormHeight - 10),
                    SizedBox(
                      width: double.infinity,
                      child: controller.isLoading.value ? Center(child: SizedBox(width:35.0,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)))) : ElevatedButton(
                        onPressed: () async{
                            controller.isLoading(true);
                            await controller.uploadImages();
                            await controller.uploadProduct(context);
                            controller.selectedColors.clear();
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
            ),
          ),
        ),
      );
  }
}
