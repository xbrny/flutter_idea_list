import 'package:flutter/material.dart';

const double kSpaceExtraSmall = 8;
const double kSpaceSmall = 12;
const double kSpaceMedium = 16;
const double kSpaceLarge = 24;
const double kSpaceExtraLarge = 32;
const double kSpaceSuperLarge = 48;

const kIdeaOrange50 = Color(0xFFFF8D60);
const kIdeaOrange100 = Color(0xFFFF8559);
const kIdeaOrange300 = Color(0xFFFF6B6B);

const kIdeaBackgroundWhite = Colors.white;

const kIdeaGradient = [kIdeaOrange50, kIdeaOrange100, kIdeaOrange300];

const kAppColor = Color(0xFFFF8559);
const kTextColor = Color(0xFFFFFFFF);

const double kScreenPadding = kSpaceLarge;

const kSmallTextStyle = TextStyle(
  fontSize: 10,
  color: kTextColor,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.8,
);

const kPageTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const kAppLinearGradient = LinearGradient(
  colors: [
    Color(0xFFFF8D60),
    Color(0xFFFF7B6C),
    Color(0xFFFF6B6B),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
