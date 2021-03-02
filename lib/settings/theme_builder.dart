import 'package:flutter/material.dart';

class ThemeBuilder {

  static const Color defaultBackground = Colors.black38;
  static const Color defaultScreen = Color.fromRGBO(170, 200, 154, 1);

  static ThemeData buildTheme(String themeId) {
    switch (themeId) {
      case 'midnight':
        return ThemeData(
          primaryColor: Color(0xFF1A2C42),     // App bar
          brightness: Brightness.light,        // Light mode or dark mode
          colorScheme: _createColorScheme(
            primary: Colors.white,             // Primary buttons
            secondary: Color(0xFF1A2C42),      // Secondary buttons
            primaryVariant: Color(0xFF0C1115), // Tertiary buttons
            secondaryVariant: defaultScreen,   // Calc screen color
            backgroundColor: defaultBackground // Background of input pad
          )
        );
      case 'orange':
        return ThemeData(
          primaryColor: Colors.deepOrange, 
          brightness: Brightness.light,
          colorScheme: _createColorScheme(
            primary: Colors.white,         
            secondary: Colors.deepOrange,  
            primaryVariant: Colors.black,  
          ) 
        );
      case 'dark':
        return ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          accentColor: Colors.blueAccent,
          colorScheme: _createColorScheme(
            primary: Colors.blueAccent,         
            secondary: Color(0xFF0b2b45),  
            primaryVariant: Colors.black,
            secondaryVariant: Color(0xFF475242),
            brightness: Brightness.dark,
            backgroundColor: Colors.grey[800]
          ) 
        );
      case 'default':
      default:
        return ThemeData(
          primaryColor: Colors.blue,    
          brightness: Brightness.light,
          colorScheme: _createColorScheme(
            primary: Colors.white, 
            secondary: Colors.blue,
            primaryVariant: Colors.black,
          )
        );
    }
  }

  // based on ColorScheme.fromSwatch()
  static ColorScheme _createColorScheme({
    Color primary,
    Color primaryVariant,
    Color secondary,
    Color secondaryVariant,
    Color backgroundColor,
    Brightness brightness = Brightness.light,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final bool primaryIsDark = ThemeData.estimateBrightnessForColor(primary) == Brightness.dark;
    final bool secondaryIsDark = ThemeData.estimateBrightnessForColor(secondary) == Brightness.dark;

    return ColorScheme(
      primary: primary,
      primaryVariant: primaryVariant ?? (isDark ? Colors.black : primary),
      secondary: secondary,
      secondaryVariant: secondaryVariant ?? (isDark ? Colors.tealAccent[700] : defaultScreen),
      surface: isDark ? Colors.grey[800] : Colors.white,
      background: backgroundColor ?? (isDark ? Colors.grey[700] : defaultBackground),
      error: Colors.red[700],
      onPrimary: primaryIsDark ? Colors.white : Colors.black,
      onSecondary: secondaryIsDark ? Colors.white : Colors.black,
      onSurface: isDark ? Colors.white : Colors.black,
      onBackground: secondaryIsDark ? Colors.white : Colors.black,
      onError: isDark ? Colors.black : Colors.white,
      brightness: brightness,
    );
  }
}
