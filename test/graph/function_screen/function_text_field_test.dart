import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';

class MockAdvancedCalculator extends Mock implements AdvancedCalculator{}

void main() {

  testWidgets("text field can be created", (WidgetTester tester) async {
    MockAdvancedCalculator calculator = MockAdvancedCalculator();
    // pump the widget wrapped in a MaterialApp Scaffold
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FunctionTextField(0, FunctionDisplayController(), calculator)
      )
    ));
    // use a finder to find the widget
    Finder fieldFinder = find.byType(FunctionTextField);
    // use a matcher to ensure it is found
    expect(fieldFinder, findsOneWidget);
  });

  testWidgets("text is updated from controller", (WidgetTester tester) async {
    MockAdvancedCalculator calculator = MockAdvancedCalculator();
    FunctionDisplayController controller = FunctionDisplayController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FunctionTextField(0, controller, calculator)
      )
    ));
    controller.input(InputItem.THREE);
    await tester.pumpAndSettle();
    Finder textFinder = find.text("3");
    expect(textFinder, findsNWidgets(1));
  });

  testWidgets("tapping text field updates active controller index", (WidgetTester tester) async {
    // TODO: not working
    
    // FunctionDisplayController controller = FunctionDisplayController();
    // controller.addField();
    
    // await tester.pumpWidget(MaterialApp(
    //   home: Scaffold(
    //     body: FunctionTextField(1, controller)
    //   )
    // ));
    // Finder fields = find.byType(FunctionTextField);
    // await tester.tap(fields.last);
    // await tester.pumpAndSettle();
    // expect(controller.currentField, 1);
  });



}
