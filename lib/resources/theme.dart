import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setel_geofence/resources/colours.dart';

final ThemeData _theme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: setelBlue500,
    accentColor: Colors.white,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: _buildTextTheme(base.textTheme),
      centerTitle: false,
      brightness: Brightness.light,
      elevation: 0.0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: setelBlue500.withOpacity(0.2),
      selectionHandleColor: setelBlue500,
    ),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    )),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: setelBlue500.withOpacity(0.5),
      labelColor: setelBlue500,
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: setelBlue500,
      disabledColor: Colors.black.withOpacity(0.6),
      textTheme: ButtonTextTheme.primary,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: setelBlue500,
        secondary: setelBlue500,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: setelBlue500,
      disabledElevation: 0.0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    primaryIconTheme: base.primaryIconTheme.copyWith(color: Colors.black),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline6: base.headline6.copyWith(
      fontFamily: GoogleFonts.cabin().fontFamily,
      fontSize: 24.0,
    ),
  );
}

ThemeData getThemeData(BuildContext context) {
  return _theme;
}
