import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences preferences;
  group("settings controller", () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({'angularUnit': 'radian', 'decimalPlaces': -1, 'isCalcScreen': true}); 
      preferences = await SharedPreferences.getInstance();
    });

    test("initial values are correct", () {
      SettingsController settingsController = SettingsController(preferences);
      expect(settingsController.angularUnit, AngularUnit.RADIAN);
      expect(settingsController.decimalPlaces, -1);
      expect(settingsController.isCalcScreen, true);
    });

    test("current tab can be updated", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setCalcScreen(false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.isCalcScreen, false);
      expect(prefs.getBool('isCalcScreen'), false);
    });

    test("angular unit can be updated", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setAngular(AngularUnit.DEGREE);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.angularUnit, AngularUnit.DEGREE);
      expect(prefs.getString('angularUnit'), 'degree');
    });

    test("decimals can be updated", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setDecimals(1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.decimalPlaces, 1);
      expect(prefs.getInt('decimalPlaces'), 1);
    });
  });

  group('Display style',(){
    test("Normal", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setDisplayStyle(DisplayStyle.NORMAL);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.displayStyle, DisplayStyle.NORMAL);
      expect(prefs.getString('displayStyle'), 'normal');
    });

    test("Scientific", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setDisplayStyle(DisplayStyle.SCIENTIFIC);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.displayStyle, DisplayStyle.SCIENTIFIC);
      expect(prefs.getString('displayStyle'), 'scientific');
    });

    test("Engineering", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setDisplayStyle(DisplayStyle.ENGINEERING);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.displayStyle, DisplayStyle.ENGINEERING);
      expect(prefs.getString('displayStyle'), 'engineering');
    });
  });
}
