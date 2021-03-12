import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsController extends ChangeNotifier {
  final SharedPreferences _prefs;
  String _currentTheme;

  SettingsController(this._prefs) {
    _currentTheme = _prefs.getString('theme') ?? 'default';
  }

  get isCalcScreen {
    return _prefs.getBool('isCalcScreen') ?? true;
  }

  Future<void> setCalcScreen(bool isCalcScreen) async {
    await _prefs.setBool('isCalcScreen', isCalcScreen);
  }

  Future<void> setDecimals(int x) async {
    await _prefs.setInt('decimalPlaces', x);
    notifyListeners();
  }

  Future<void> setAngular(AngularUnit unit) async {
    if (unit == AngularUnit.DEGREE)
      await _prefs.setString('angularUnit', 'degree');
    else
      await _prefs.setString('angularUnit', 'radian');
    notifyListeners();
  }

  Future<void> setDisplayStyle(DisplayStyle style) async {
    if (style == DisplayStyle.SCIENTIFIC) {
      await _prefs.setString('displayStyle', 'scientific');
    } else if(style == DisplayStyle.ENGINEERING) {
      await _prefs.setString('displayStyle', 'engineering');
    } else{
      await _prefs.setString('displayStyle', 'normal');
    }
    notifyListeners();
  }

  get displayStyle {
    String style = _prefs.getString('displayStyle') ?? 'normal';
    DisplayStyle displayStyle;
    if (style == 'engineering') {
      displayStyle = DisplayStyle.ENGINEERING;
    }else if(style == 'scientific') {
      displayStyle = DisplayStyle.SCIENTIFIC;
    }else{
      displayStyle = DisplayStyle.NORMAL;
    }

    return displayStyle;
  }
  
  get decimalPlaces {
    return _prefs.getInt('decimalPlaces') ?? -1;
  }

  get angularUnit {
    String angularUnit = _prefs.getString('angularUnit') ?? 'radian';
    if (angularUnit == 'radian')
      return AngularUnit.RADIAN;
    else
      return AngularUnit.DEGREE;
  }

  get currentTheme {
    return _currentTheme;
  }

  Future<void> setTheme(String theme) async {
    _currentTheme = theme;
    notifyListeners();
    await _prefs.setString('theme', theme);
  }
  
  get calculationOptions{
    CalculationOptions options = CalculationOptions();
    options.angularUnit = angularUnit;
    options.displayStyle = displayStyle;
    options.decimalPlaces = decimalPlaces;

    return options;
  }

  // get the controller from any page
  static SettingsController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<SettingsControllerProvider>();
    return provider.controller;
  }
}

// InheritedWidget so settings can be accessed from anywhere
class SettingsControllerProvider extends InheritedWidget {
  const SettingsControllerProvider({Key key, this.controller, Widget child}) : super(key: key, child: child);

  final SettingsController controller;

  @override
  bool updateShouldNotify(SettingsControllerProvider old) => controller != old.controller;
}

