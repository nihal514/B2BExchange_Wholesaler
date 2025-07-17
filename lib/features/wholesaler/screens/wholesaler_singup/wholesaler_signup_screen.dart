import 'package:b2b_exchange_development_version/constants/image_strings.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/constants/text_strings.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_singup/wholesaler_form_header_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_singup/wholesaler_signup_footer_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_singup/wholesaler_signup_form_widget.dart';
import 'package:flutter/material.dart';

class WSignUpScreen extends StatelessWidget {
  const WSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              children: const [
                WFormHeaderWidget(
                  image: myShopingBasketWithPhone,
                  title: mySignUpTitle,
                  subTitle: mySignUpSubTitle,
                  imageHeight: 0.15,
                ),
                WSignUpFormWidget(),
                WSignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
