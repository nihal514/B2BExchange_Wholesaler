import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/constants/text_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/controllers/wholesaler_signup_controller.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_login/wholesaler_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WSignUpFooterWidget extends StatelessWidget {
  const WSignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        // const SizedBox(height: myFormHeight - 20),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {
        //       WSignUpController.instance.registerWholesalerWithGoogle();
        //     },
        //     icon: const Image(
        //       image: AssetImage(myGoogleLogo),
        //       width: 20.0,
        //     ),
        //     label: Text(mySignInWithGoogle.toUpperCase()),
        //   ),
        //
        // ),
        const SizedBox(height: myFormHeight - 20),
        TextButton(
          onPressed: () {
            Get.offAll(const WLoginScreen());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: myAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: myLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
