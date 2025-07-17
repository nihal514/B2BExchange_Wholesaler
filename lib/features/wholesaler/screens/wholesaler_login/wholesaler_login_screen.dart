import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_login/wholesaler_login_footer_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_login/wholesaler_login_form_widget.dart';
import 'package:b2b_exchange_development_version/features/wholesaler/screens/wholesaler_login/wholesaler_login_header_widget.dart';
import 'package:flutter/material.dart';

class WLoginScreen extends StatelessWidget {
  const WLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(myDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                WLoginHeaderWidget(),
                WLoginForm(),
                WLoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
