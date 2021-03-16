import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/dialog/clear_dialog.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockCalculatorDisplayController extends Mock implements CalculatorDisplayController{}
class BoolWrapper {
  bool boolean = false;
}

void main(){
  SettingsController settingsController;

  Widget buildDialog({BoolWrapper called, MockNavigatorObserver observer}) {
    observer = observer ?? MockNavigatorObserver();
    called = called ?? BoolWrapper();
    return Builder(
      builder: (BuildContext context) {
        return SettingsControllerProvider(
          controller: settingsController,
          child: MaterialApp(
            home: ClearDialog(() {
              called.boolean = true;
            }),
            navigatorObservers: [observer],
          )
        );
      }
    );
  }

  group('Dialog: ', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({'theme': 'default'}); 
      SharedPreferences pref = await SharedPreferences.getInstance();
      settingsController = SettingsController(pref);
      settingsController.setCalcHistory([
        DisplayHistory([InputItem.TWO,InputItem.ADD,InputItem.THREE], '5'),
        DisplayHistory([InputItem.SIX], '6')
      ]);
      settingsController.setCalcItems(2);
    });

    testWidgets('closes', (WidgetTester tester) async{
      MockNavigatorObserver observer = MockNavigatorObserver();
      await tester.pumpWidget(buildDialog(observer: observer));
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      verify(observer.didPop(any, any));
    });

    group('Clear history', () {
      testWidgets('updates settings', (WidgetTester tester) async{
        await tester.pumpWidget(buildDialog());
        await tester.tap(find.text('Clear History'));
        await tester.pumpAndSettle();
        expect(settingsController.calcHistory, []);
        expect(settingsController.calcItems, 0);
      });

      testWidgets('calls clear function', (WidgetTester tester) async{
        BoolWrapper called = BoolWrapper();
        await tester.pumpWidget(buildDialog(called: called));
        await tester.tap(find.text('Clear History'));
        await tester.pumpAndSettle();
        expect(called.boolean, true);
      });
    });
    
    testWidgets('Clear variables', (WidgetTester tester) async{
      await tester.pumpWidget(buildDialog());
      await tester.tap(find.text('Clear Variables'));
      await tester.pumpAndSettle();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('A'), isNull);
      expect(prefs.getString('B'), isNull);
      expect(prefs.getString('C'), isNull);
      expect(prefs.getString('D'), isNull);
      expect(prefs.getString('E'), isNull);
      expect(prefs.getString('F'), isNull);
      expect(prefs.getString('G'), isNull);
    });
    group('Reset', () {
      testWidgets('resets settings', (WidgetTester tester) async{
        await tester.pumpWidget(buildDialog());
        await tester.tap(find.text('Reset Memory'));
        await tester.pumpAndSettle();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('calcHistory'), isNull);
        expect(prefs.getInt('calcItems'), isNull);
        expect(prefs.getString('A'), isNull);
        expect(prefs.getString('displayStyle'), isNull);
        expect(prefs.getString('angularUnit'), isNull);
        expect(prefs.getInt('decimalPlaces'), isNull);
        expect(prefs.getBool('isCalcScreen'), isNull);
        expect(prefs.getString('theme'), 'default');
      });

      testWidgets('calls clear function', (WidgetTester tester) async{
        BoolWrapper called = BoolWrapper();
        await tester.pumpWidget(buildDialog(called: called));
        await tester.tap(find.text('Reset Memory'));
        await tester.pumpAndSettle();
        expect(called.boolean, true);
      });
    });
  });
}
