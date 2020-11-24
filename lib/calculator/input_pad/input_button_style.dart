import 'package:flutter/material.dart';

class InputButtonStyle{
  static const BorderRadius _SMALL_RADIUS = BorderRadius.all(Radius.circular(10));
  static const BorderRadius _LARGE_RADIUS = BorderRadius.only(
      topLeft: Radius.elliptical(20, 10),
      topRight: Radius.elliptical(20, 10),
      bottomLeft: Radius.elliptical(25, 15),
      bottomRight: Radius.elliptical(25, 15)
  );

  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final BorderRadius radius;
  final FontWeight fontWeight;

  const InputButtonStyle(this.textColor, this.backgroundColor, this.fontSize, this.radius, [this.fontWeight=FontWeight.normal]);

  static const WHITE_ROUNDED = const InputButtonStyle(Colors.black, Colors.white, 32,_LARGE_RADIUS, FontWeight.bold);
  static const BLUE_LARGE_TEXT = const InputButtonStyle(Colors.white, Colors.blue, 24,_SMALL_RADIUS);
  static const BLACK_SMALL_TEXT = const InputButtonStyle(Colors.white, Colors.black, 20,_SMALL_RADIUS);
  static const WHITE_LARGE_TEXT = const InputButtonStyle(Colors.black, Colors.white, 24,_SMALL_RADIUS);
  static const WHITE_SMALL_TEXT = const InputButtonStyle(Colors.black, Colors.white, 20,_SMALL_RADIUS);
}