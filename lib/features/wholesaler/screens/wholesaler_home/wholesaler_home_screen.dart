import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_appbar_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/whs_button_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_products/wholesaler_product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class WholesalerHomeScreen extends StatelessWidget {
  const WholesalerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Show a confirmation dialog
          bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you want to exit the app?"),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: Text("Exit"),
                  onPressed: () => SystemNavigator.pop(),
                ),
              ],
            ),
          );
          // If the user confirms, exit the app
          return confirm ?? false;
        },
      child: Scaffold(
          appBar: WAppBarWidget("Wholesaler Dashboard"),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Products")
                .where('vendor_id',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;

                data = data.sortedBy((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

                double sum = 0.0;
                for (var item in data) {
                  sum = sum + double.parse(item['p_rating']);
                }
                double average = sum / data.length;

                var totalOrders=0.obs;
                var totalSales=0.obs;
                FirebaseFirestore.instance
                    .collection("Orders")
                    .where('vendors', arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty) {
                    totalOrders.value = value.docs.length;
                    for(var item in value.docs)
                    {
                      for (var orders in item['orders'])
                      {
                        totalSales.value+=int.parse("${orders['tprice']}");
                      }
                    }
                  }
                });
                totalOrders.value=totalOrders.value;
                totalSales.value=totalSales.value;


                return Obx(()=> Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WHSButtonWidget(
                                  title: "Products",
                                  count: "${data.length}",
                                  logo: myProducts),
                              WHSButtonWidget(
                                  title: "Orders",
                                  count: "${totalOrders}",
                                  logo: myOrders),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WHSButtonWidget(
                                  title: "Ratings",
                                  count: "${average}",
                                  logo: myStar),
                              WHSButtonWidget(
                                  title: "Sales",
                                  count: "${totalSales}",
                                  logo: myShopingBasket),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Text("Popular Products",
                              style:
                                  const TextStyle(color: darkGrey, fontSize: 16.0)),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (data[index]['p_wishlist'] == 0) {
                                    return const SizedBox();
                                  } else {
                                    return ListTile(
                                      onTap: () {
                                        Get.to(
                                            () => WProductDetails(data: data[index]));
                                      },
                                      leading: Image.network(data[index]['p_imgs'][0],
                                          height: 100, fit: BoxFit.cover),
                                      title: Text("${data[index]['p_name']}",
                                          style: const TextStyle(color: darkGrey)),
                                      subtitle: Text("${data[index]['p_price']}",
                                          style: const TextStyle(color: lightGrey)),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                );
              } else {
                return Center(
                    child: SizedBox(
                        width: 35.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.red))));
              }
            },
          )),
    );
  }




}
