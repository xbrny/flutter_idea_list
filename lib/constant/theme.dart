import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';

ThemeData get kIdeaTheme {
  final base = ThemeData.light();

  return base.copyWith(
      primaryColor: kIdeaOrange300,
      accentColor: kIdeaOrange300,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: Colors.white,
        shape: StadiumBorder(),
      ),
      textSelectionColor: kIdeaOrange300,
      scaffoldBackgroundColor: kIdeaBackgroundWhite,
      textTheme: _buildIdeaTextTheme(base.textTheme),
      primaryTextTheme: _buildIdeaTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildIdeaTextTheme(base.accentTextTheme),
      appBarTheme: _buildAppBarTheme(base.appBarTheme),
      inputDecorationTheme: kInputDecorationTheme,
      floatingActionButtonTheme:
          _buildFloatingActionButtonTheme(base.floatingActionButtonTheme));
}

FloatingActionButtonThemeData _buildFloatingActionButtonTheme(
    FloatingActionButtonThemeData base) {
  return base.copyWith(
    backgroundColor: kIdeaOrange300,
  );
}

AppBarTheme _buildAppBarTheme(AppBarTheme base) {
  return base.copyWith(
    color: Colors.transparent,
    iconTheme: IconThemeData(
      color: kIdeaOrange300,
    ),
    elevation: 0,
    textTheme: TextTheme(
      title: TextStyle(
        color: kIdeaOrange300,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'Nunito',
      ),
    ),
  );
}

InputDecorationTheme get kInputDecorationTheme {
  return InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.3),
        width: 3,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kIdeaOrange300,
        width: 3,
      ),
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    helperStyle: TextStyle(
      color: Colors.grey,
    ),
    focusColor: kIdeaOrange300,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      letterSpacing: 0.8,
    ),
  );
}

InputDecorationTheme get kInputDecorationThemeOnDarkBg {
  return InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.2),
        width: 3,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(0.7),
      fontSize: 15,
      letterSpacing: 0.8,
    ),
  );
}

TextTheme _buildIdeaTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: kIdeaOrange300,
        ),
        title: base.title.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10.0,
          letterSpacing: 0.8,
          color: Colors.grey.shade600,
        ),
        body1: base.body1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w700,
          color: kIdeaOrange300,
          fontSize: 14,
          letterSpacing: 0.8,
        ),
      )
      .apply(
        fontFamily: 'Nunito',
      );
}
