import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/dialog/theme_dialog.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  SettingsController settingsController;

  Widget buildDialog({MockNavigatorObserver observer}) {
    observer = observer ?? MockNavigatorObserver();
    return Builder(
      builder: (BuildContext context) {
        return SettingsControllerProvider(
          controller: settingsController,
          child: MaterialApp(
            home: ThemeDialog(),
            navigatorObservers: [observer],
          )
        );
      }
    );
  }

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({'theme': 'default'}); 
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

  group('Theme changes',(){
    testWidgets('to midnight', (WidgetTester tester) async{
      await tester.pumpWidget(buildDialog());
      await tester.tap(find.text('Midnight'));
      await tester.pumpAndSettle();
      SharedPreferences pref = await SharedPreferences.getInstance();
      expect(settingsController.currentTheme, 'midnight');
      expect(pref.getString('theme'), 'midnight');
    });

    testWidgets('to orange', (WidgetTester tester) async{
      await tester.pumpWidget(buildDialog());
      await tester.tap(find.text('Orange'));
      await tester.pumpAndSettle();
      SharedPreferences pref = await SharedPreferences.getInstance();
      expect(settingsController.currentTheme, 'orange');
      expect(pref.getString('theme'), 'orange');
    });

    testWidgets('to dark', (WidgetTester tester) async{
      await tester.pumpWidget(buildDialog());
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();
      SharedPreferences pref = await SharedPreferences.getInstance();
      expect(settingsController.currentTheme, 'dark');
      expect(pref.getString('theme'), 'dark');
    });

    testWidgets('to default', (WidgetTester tester) async{
      await tester.pumpWidget(buildDialog());
      await tester.tap(find.text('Default'));
      await tester.pumpAndSettle();
      SharedPreferences pref = await SharedPreferences.getInstance();
      expect(settingsController.currentTheme, 'default');
      expect(pref.getString('theme'), 'default');
    });
  });
}
