import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/controllers/home_controller.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_home/wholesaler_home_screen.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_orders/wholesaler_orders_screen.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_products/wholesaler_products_screen.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_profile/wholesaler_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';

class WholesalerHome extends StatelessWidget {
  const WholesalerHome({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const WholesalerHomeScreen(),
      const WholesalerProductsScreen(),
      const WholesalerOrdersScreen(),
      const WholesalerProfileScreen()
    ];

    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(myHomeLogo, height: 24), label: "dashboard"),
      BottomNavigationBarItem(
          icon: Image.asset(myProducts, height: 24), label: "products"),
      BottomNavigationBarItem(
          icon: Image.asset(myOrders, height: 24), label: "orders"),
      BottomNavigationBarItem(
          icon: Image.asset(myAccout, height: 24), label: "Profile"),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ), // BottomlavigationBar
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    ); // Scaffold
  }
}
