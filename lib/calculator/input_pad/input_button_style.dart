import 'package:flutter/material.dart';

class InputButtonStyle{
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final BorderRadius radius;
  final FontWeight fontWeight;
  final EdgeInsets padding;

  const InputButtonStyle(
    this.textColor, 
    this.backgroundColor, 
    this.fontSize, 
    this.radius, {
    this.fontWeight=FontWeight.normal, 
    this.padding
  });
  
  static const BorderRadius _SMALL_RADIUS = BorderRadius.all(Radius.circular(10));
  static const BorderRadius _LARGE_RADIUS = BorderRadius.only(
      topLeft: Radius.elliptical(20, 10),
      topRight: Radius.elliptical(20, 10),
      bottomLeft: Radius.elliptical(25, 15),
      bottomRight: Radius.elliptical(25, 15)
  );

  static InputButtonStyle primary(BuildContext context) { 
    return InputButtonStyle(Colors.black, Theme.of(context).colorScheme.primary, 32, _LARGE_RADIUS, fontWeight:FontWeight.bold); 
  }

  static InputButtonStyle secondary(BuildContext context) { 
    return InputButtonStyle(Colors.white, Theme.of(context).colorScheme.secondary, 24, _SMALL_RADIUS);
  }

  static InputButtonStyle tertiary(BuildContext context) { 
    return InputButtonStyle(Colors.white, Theme.of(context).colorScheme.primaryVariant, 20, _SMALL_RADIUS); 
  }

  static InputButtonStyle quartenary(BuildContext context) { 
    return InputButtonStyle(Colors.black, Theme.of(context).colorScheme.primary, 24, _SMALL_RADIUS); 
  }

  // override comparison for testing
  bool operator ==(o) => 
    o is InputButtonStyle &&
    o.textColor == textColor &&
    o.backgroundColor == backgroundColor &&
    o.fontSize == fontSize &&
    o.radius == radius &&
    o.fontWeight == fontWeight &&
    o.padding == padding;
  
  int get hashCode => textColor.hashCode ^ backgroundColor.hashCode ^ fontSize.hashCode ^ 
    radius.hashCode ^ fontWeight.hashCode ^ padding.hashCode;

}
