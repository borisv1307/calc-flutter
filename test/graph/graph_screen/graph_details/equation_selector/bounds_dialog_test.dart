import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/graph/graph_screen/graph_details/equation_selector/bounds_dialog.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line_bounds.dart';
import 'package:open_calc/settings/settings_controller.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  SettingsController settingsController;

  Widget buildDialog({GraphLineBounds bounds, MockNavigatorObserver observer}) {
    observer = observer ?? MockNavigatorObserver();
    return Builder(
      builder: (BuildContext context) {
        return SettingsControllerProvider(
          controller: settingsController,
          child: MaterialApp(
            home: BoundsDialog(bounds ?? GraphLineBounds()),
            navigatorObservers: [observer],
          )
        );
      }
    );
  }

  testWidgets('Close dialog', (WidgetTester tester) async{
    MockNavigatorObserver observer = MockNavigatorObserver();
    await tester.pumpWidget(buildDialog(observer: observer));
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    verify(observer.didPop(any, any));
  });

  testWidgets('min x is displayed', (WidgetTester tester) async{
    await tester.pumpWidget(buildDialog());
    expect(find.text('X min'), findsWidgets);
  });

  testWidgets('min y is displayed', (WidgetTester tester) async{
    await tester.pumpWidget(buildDialog());
    expect(find.text('Y min'), findsWidgets);
  });

  testWidgets('max x is displayed', (WidgetTester tester) async{
    await tester.pumpWidget(buildDialog());
    expect(find.text('X max'), findsWidgets);
  });

  testWidgets('max y is displayed', (WidgetTester tester) async{
    await tester.pumpWidget(buildDialog());
    expect(find.text('Y max'), findsWidgets);
  });
}
