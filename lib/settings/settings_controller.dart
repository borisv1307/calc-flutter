import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingsController extends ChangeNotifier {
  final SharedPreferences _prefs;

  SettingsController(this._prefs);

  get isCalcScreen {
    int tabNumber = _prefs.getInt('tabNumber') ?? 1;
    return (tabNumber == 1) ? true : false;
  }

  Future<void> setCalcScreen(bool isCalcScreen) async {
    if (isCalcScreen)
      await _prefs.setInt('tabNumber', 1);
    else
      await _prefs.setInt('tabNumber', 0);
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

