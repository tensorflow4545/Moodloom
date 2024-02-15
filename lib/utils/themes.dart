import 'package:flutter/material.dart';
import 'package:HappyLink/utils/colors.dart';

class AppTheme {
  final Color? primaryColor;
  final Color? accentColor;
  final Color? backgroundColor;
  final Color? scafholdColor;

  AppTheme(
      {this.primaryColor,
      this.accentColor,
      this.backgroundColor,
      this.scafholdColor});
}

class RelaxTheme extends AppTheme {
  RelaxTheme()
      : super(
            primaryColor: CustomColors.relaxColor,
            accentColor: Colors.orange,
            backgroundColor: Colors.orange.withOpacity(0.2),
            scafholdColor: CustomColors.relaxColor.withOpacity(0.2));
}

class FocusTheme extends AppTheme {
  FocusTheme()
      : super(
            primaryColor: CustomColors.focusColor,
            accentColor: Colors.amber,
            backgroundColor: Colors.grey[900]!,
            scafholdColor: CustomColors.focusColor.withOpacity(0.2));
}

class HappyTheme extends AppTheme {
  HappyTheme()
      : super(
            primaryColor: CustomColors.happyColor,
            accentColor: Colors.orange,
            backgroundColor: Colors.white,
            scafholdColor: CustomColors.happyColor.withOpacity(0.2));
}

class CalmTheme extends AppTheme {
  CalmTheme()
      : super(
            primaryColor: CustomColors.calmColor,
            accentColor: Colors.amber,
            backgroundColor: Colors.grey[900]!,
            scafholdColor: CustomColors.calmColor.withOpacity(0.2));
}

// Define more themes as needed
