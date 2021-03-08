import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences preferences;
  group("settings controller", () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({'angularUnit': 'radian', 'decimalPlaces': -1, 'isCalcScreen': true, 'theme': 'default'}); 
      preferences = await SharedPreferences.getInstance();
    });

    test("initial values are correct", () {
      SettingsController settingsController = SettingsController(preferences);
      expect(settingsController.angularUnit, AngularUnit.RADIAN);
      expect(settingsController.decimalPlaces, -1);
      expect(settingsController.isCalcScreen, true);
      expect(settingsController.currentTheme, 'default');
    });

    test("current tab can be updated", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setCalcScreen(false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.isCalcScreen, false);
      expect(prefs.getBool('isCalcScreen'), false);
    });
    
    test("decimals can be updated", () async {
      SettingsController settingsController = SettingsController(preferences);
      await settingsController.setDecimals(1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(settingsController.decimalPlaces, 1);
      expect(prefs.getInt('decimalPlaces'), 1);
    });

    group("angular unit", () {
      test("degree", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setAngular(AngularUnit.DEGREE);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.angularUnit, AngularUnit.DEGREE);
        expect(prefs.getString('angularUnit'), 'degree');
      });

      test("radian", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setAngular(AngularUnit.RADIAN);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.angularUnit, AngularUnit.RADIAN);
        expect(prefs.getString('angularUnit'), 'radian');
      });
    });

    group("theme", () {
      test("midnight", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setTheme('midnight');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.currentTheme, 'midnight');
        expect(prefs.getString('theme'), 'midnight');
      });

      test("orange", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setTheme('orange');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.currentTheme, 'orange');
        expect(prefs.getString('theme'), 'orange');
      });

      test("dark", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setTheme('dark');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.currentTheme, 'dark');
        expect(prefs.getString('theme'), 'dark');
      });

      test("default", () async {
        SettingsController settingsController = SettingsController(preferences);
        await settingsController.setTheme('default');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(settingsController.currentTheme, 'default');
        expect(prefs.getString('theme'), 'default');
      });
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
