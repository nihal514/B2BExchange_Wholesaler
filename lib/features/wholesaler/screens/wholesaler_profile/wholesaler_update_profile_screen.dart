import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/constants/text_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/controllers/wholesaler_profile_controller.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/models/wholesaler_model.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class WUpdateProfileScreen extends StatelessWidget {
  const WUpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WProfileController());
    return Scaffold(
      appBar: WAppBarWidget("Wholesaler Update Profile"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(myDefaultSize),
          child: FutureBuilder(
            future: controller.getWholesalerData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  WholesalerModel wholesalerData =
                      snapshot.data as WholesalerModel;

                  //TextField Controllers to get data from TextFields
                  final email =
                      TextEditingController(text: wholesalerData.email);
                  final password =
                      TextEditingController(text: wholesalerData.password);
                  final fullName =
                      TextEditingController(text: wholesalerData.fullName);
                  final phoneNo =
                      TextEditingController(text: wholesalerData.phoneNo);
                  final imageLink = wholesalerData.imageLink;

                  return Obx(
                    () => Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.imageChanged.value
                                      ? Image.file(controller.wImage!)
                                      : imageLink == null
                                          ? Image(
                                              image: AssetImage(
                                                  myShopingBasketWithPhone))
                                          : Image.network(imageLink!)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: myPrimaryColor,
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.alternate_pencil,
                                    color: Colors.black,
                                    size: 20,
                                  ).onTap(() {
                                    controller.pickWholesalerImage();
                                  })),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Form(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: fullName,
                                decoration: const InputDecoration(
                                    label: Text(myFullName),
                                    prefixIcon:
                                        Icon(Icons.person_outline_rounded)),
                              ),
                              const SizedBox(height: myFormHeight - 20),
                              TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                    label: Text(myEmail),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              const SizedBox(height: myFormHeight - 20),
                              TextFormField(
                                controller: phoneNo,
                                decoration: const InputDecoration(
                                    label: Text(myPhoneNo),
                                    prefixIcon: Icon(Icons.numbers)),
                              ),
                              const SizedBox(height: myFormHeight - 20),
                              TextFormField(
                                controller: password,
                                decoration: const InputDecoration(
                                    label: Text(myPassword),
                                    prefixIcon: Icon(Icons.fingerprint)),
                              ),
                              const SizedBox(height: myFormHeight - 10),
                              SizedBox(
                                width: double.infinity,
                                child: controller.isLoading.value
                                    ? Center(
                                        child: SizedBox(
                                            width: 35.0,
                                            child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.red))))
                                    : ElevatedButton(
                                        onPressed: () async {
                                          controller.isLoading(true);
                                          await controller
                                              .uploadWholesalerImage();

                                          final wholesaler = WholesalerModel(
                                              id: wholesalerData.id,
                                              email: email.text.trim(),
                                              password: password.text.trim(),
                                              fullName: fullName.text.trim(),
                                              phoneNo: phoneNo.text.trim(),
                                              imageLink:
                                                  controller.imageLink);

                                          await controller
                                              .updateRecord(wholesaler);
                                          controller.isLoading(false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: myPrimaryColor,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            foregroundColor: Colors.black),
                                        child:
                                            Text(myEditProfile.toUpperCase()),
                                      ),
                              ),
                              // const SizedBox(height: 30),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const Text.rich(TextSpan(
                              //         text: myJoinedAt,
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 12))),
                              //     ElevatedButton(
                              //       onPressed: () {},
                              //       style: ElevatedButton.styleFrom(
                              //           backgroundColor:
                              //               Colors.redAccent.withOpacity(0.1),
                              //           elevation: 0,
                              //           foregroundColor: Colors.red,
                              //           shape: const StadiumBorder(),
                              //           side: BorderSide.none),
                              //       child: const Text(myDelete),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
