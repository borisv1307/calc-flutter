import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/mode/mode_dialog.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  SettingsController settingsController;

  Widget buildDialog({CalculationOptions options, MockNavigatorObserver observer}) {
    observer = observer ?? MockNavigatorObserver();
    return Builder(
      builder: (BuildContext context) {
        return SettingsControllerProvider(
          controller: settingsController,
          child: MaterialApp(
            home: ModeDialog(options ?? CalculationOptions()),
            navigatorObservers: [observer],
          )
        );
      }
    );
  }

  group("Mode", () {
    
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({'angularUnit': 'radian', 'decimalPlaces': -1}); 
      SharedPreferences pref = await SharedPreferences.getInstance();
      settingsController = SettingsController(pref);
    });

    testWidgets('Close dialog', (WidgetTester tester) async{
      MockNavigatorObserver observer = MockNavigatorObserver();
      await tester.pumpWidget(buildDialog(observer: observer));
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      verify(observer.didPop(any, any));
    });

    group('Decimal places',(){
      testWidgets('are displayed', (WidgetTester tester) async{
        await tester.pumpWidget(buildDialog());
        await tester.tap(find.text('max'));
        await tester.pumpAndSettle();
        expect(find.text('Decimal places'), findsWidgets);
        expect(find.text('max'), findsWidgets);
        expect(find.text('0'), findsWidgets);
        expect(find.text('1'), findsWidgets);
        expect(find.text('2'), findsWidgets);
        expect(find.text('3'), findsWidgets);
        expect(find.text('4'), findsWidgets);
        expect(find.text('5'), findsWidgets);
        expect(find.text('6'), findsWidgets);
        expect(find.text('7'), findsWidgets);
        expect(find.text('8'), findsWidgets);
        expect(find.text('9'), findsWidgets);
      });

      testWidgets('can be updated', (WidgetTester tester) async{
        CalculationOptions options = CalculationOptions();
        await tester.pumpWidget(buildDialog(options: options));
        await tester.tap(find.text('max'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3').last);
        expect(options.decimalPlaces,3);
      });
    });

    group('Angular unit',(){
      testWidgets('are displayed', (WidgetTester tester) async{
        await tester.pumpWidget(buildDialog());
        await tester.tap(find.text('radian'));
        await tester.pumpAndSettle();
        expect(find.text('Angular unit'), findsWidgets);
        expect(find.text('radian'), findsWidgets);
        expect(find.text('degree'), findsWidgets);
      });

      testWidgets('can be updated', (WidgetTester tester) async{
        CalculationOptions options = CalculationOptions();
        await tester.pumpWidget(buildDialog(options: options));
        await tester.tap(find.text('radian'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('degree').last);
        await tester.pumpAndSettle();
        expect(options.angularUnit,AngularUnit.DEGREE);
      });
    });

    group('Display style',(){
      testWidgets('are displayed', (WidgetTester tester) async{
        await tester.pumpWidget(buildDialog());
        await tester.tap(find.text('normal'));
        await tester.pumpAndSettle();
        expect(find.text('Display style'), findsWidgets);
        expect(find.text('normal'), findsWidgets);
        expect(find.text('scientific'), findsWidgets);
        expect(find.text('engineering'), findsWidgets);
      });

      testWidgets('can be updated', (WidgetTester tester) async{
        CalculationOptions options = CalculationOptions();
        await tester.pumpWidget(buildDialog(options: options));
        await tester.tap(find.text('normal'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('scientific').last);
        await tester.pumpAndSettle();
        expect(options.displayStyle,DisplayStyle.SCIENTIFIC);
      });
    });
  });
}
