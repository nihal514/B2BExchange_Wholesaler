import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/constants/text_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_login/wholesaler_login_screen.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_singup/wholesaler_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? mySecondaryColor : Colors.white,
      body: Container(
        padding: const EdgeInsets.all(myDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Wholesaler Side",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0)),
            Image(
                image: const AssetImage(myShopingBasket), height: height * 0.6),
            Column(
              children: [
                Text(myWelcomeTitle,
                    style: Theme.of(context).textTheme.displaySmall),
                Text(myWelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => const WLoginScreen()),
                    child: Text(myLogin.toUpperCase()),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const WSignUpScreen()),
                    child: Text(mySignup.toUpperCase()),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
