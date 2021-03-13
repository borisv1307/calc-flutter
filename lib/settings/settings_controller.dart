import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/variable_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SettingsController extends ChangeNotifier {
  static const int MAX_MEMORY_ITEMS = 10;
  final SharedPreferences _prefs;
  final VariableStorage _storage;
  String _currentTheme;


  SettingsController(this._prefs, [storage]) :
      this._storage = storage ?? VariableStorage.loadFromPrefs(_prefs),
      this._currentTheme = _prefs.getString('theme') ?? 'default';

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
  
  Future<void> setTheme(String theme) async {
    _currentTheme = theme;
    notifyListeners();
    await _prefs.setString('theme', theme);
  }

  Future<void> storeVariable(String key, String value) async {
    _storage.setVariable(key, value);
    await _prefs.setString(key, value);
  }

  Future<void> setFunctionList(List<List<InputItem>> functions) async {
    List<List<Map>> jsonFunctions = [];
    for (List<InputItem> func in functions) {
      List<Map> currentJsonFunction = [];
      for (InputItem item in func) {
        currentJsonFunction.add(item.toJson());
      }
      jsonFunctions.add(currentJsonFunction);
    }
    Map<String, dynamic> jsonData = Map<String, dynamic>();
    jsonData['data'] = jsonFunctions;
    await _prefs.setString('functions', json.encode(jsonData));
  }

  Future<void> setCalcHistory(List<DisplayHistory> history) async {
    List<Map<String, dynamic>> jsonHistoryItems = [];
    for (int i = 0; i < history.length && i < MAX_MEMORY_ITEMS; i++) {
      jsonHistoryItems.add(history[i].toJson());
    }
    Map<String, dynamic> jsonData = Map<String, dynamic>();
    jsonData['data'] = jsonHistoryItems;
    await _prefs.setString('calcHistory', json.encode(jsonData));
  }
  
  get isCalcScreen {
    return _prefs.getBool('isCalcScreen') ?? true;
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
  
  get calculationOptions{
    CalculationOptions options = CalculationOptions();
    options.angularUnit = angularUnit;
    options.displayStyle = displayStyle;
    options.decimalPlaces = decimalPlaces;

    return options;
  }

  get functionHistory {
    String jsonData = _prefs.getString('functions');
    List jsonFunctions = (jsonData != null) ? json.decode(jsonData)['data'] : [];
    List<List<InputItem>> loadedFunctions = [];
    for (List func in jsonFunctions) {
      List<InputItem> currentFunction = [];
      for (Map<String, dynamic> jsonItem in func) {
        currentFunction.add(InputItem.fromJson(jsonItem));
      }
      loadedFunctions.add(currentFunction);
    }
    return loadedFunctions;
  }

  get calcHistory {
    String jsonData = _prefs.getString('calcHistory');
    List jsonHistoryItems = (jsonData != null) ? json.decode(jsonData)['data'] : [];
    List<DisplayHistory> history = [];
    for (Map<String, dynamic> jsonItem in jsonHistoryItems) {
      history.add(DisplayHistory.fromJson(jsonItem));
    }
    return history;
  }

  String fetchVariable(String key) {
    return _storage.getVariable(key);
  }

  get variableStorage {
    return _storage;
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

