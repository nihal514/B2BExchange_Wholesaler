import 'package:b2b_exchange_development_version/constants/colors.dart';
import 'package:b2b_exchange_development_version/constants/sizes.dart';
import 'package:flutter/material.dart';

class MyOutlinedButtonTheme{
  /* -- Light theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: mySecondaryColor,
        side: BorderSide (color: mySecondaryColor),
        padding: EdgeInsets.symmetric (vertical: myButtonHeight),
      ),
  );

  /* -- Dark theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: myWhiteColor,
      side: BorderSide (color: myWhiteColor),
      padding: EdgeInsets.symmetric (vertical: myButtonHeight),
    ),
  );

}