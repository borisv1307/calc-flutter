import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/function_screen.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_pad.dart';

class MockAdvancedCalculator extends Mock implements AdvancedCalculator{}


void main() {

  FunctionDisplayController controller;
  VariableStorage storage;
  MockAdvancedCalculator calculator;

  setUp(() {
    storage = VariableStorage();
    controller = FunctionDisplayController();
    calculator = MockAdvancedCalculator();
  });


  // widget tests: for testing widget behavior
  group("Input field widget tests:", () {
    testWidgets("function screen can be created", (WidgetTester tester) async {
      // pump the widget wrapped in a MaterialApp Scaffold
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      // use a finder to find the widget
      Finder screenFinder = find.byType(FunctionScreen);

      // use a matcher to ensure it is found
      expect(screenFinder, findsNWidgets(1));
    });

    testWidgets("function screen begins with 1 input field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      expect(find.byType(FunctionTextField), findsNWidgets(1));
    });

    testWidgets("+ button adds input field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );    
      // find + Button by searching for its icon
      Finder addButton = find.byIcon(Icons.add);
      // simulate a tap
      await tester.tap(addButton);
      // wait for changes
      await tester.pumpAndSettle();
      expect(find.byType(FunctionTextField), findsNWidgets(2));
    });

    testWidgets("correct number of remove buttons", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: new FunctionScreen(storage, controller, calculator)))
      );       
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.remove), findsNWidgets(2));
    });

    testWidgets("remove button removes 2nd text field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      ); 
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      Finder removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.at(1));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.remove), findsNWidgets(1));
      
      // find remaining text field
      FunctionTextField field = tester.widget(find.byType(FunctionTextField));
      // ensure correct index
      expect(field.index, 0);
    });
  });

  group("Input pad widget tests", () {
    testWidgets("input pad is created", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      Finder padFinder = find.byType(GraphInputPad);
      expect(padFinder, findsNWidgets(1));
    });

    testWidgets("text field receives input when button is pressed", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      await tester.tap(find.text("y1= "));
      await tester.pumpAndSettle();
      Finder buttonFinder = find.text("𝑥");
      await tester.tap(buttonFinder);
      TextField firstField = find.byType(TextField).evaluate().first.widget as TextField;
      expect(firstField.controller.text, "𝑥");
    });

    testWidgets("multiple values can be added and removed", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      TextField firstField = find.byType(TextField).evaluate().first.widget as TextField;
      await tester.tap(find.text("𝑥"));
      await tester.tap(find.text("^"));
      await tester.tap(find.text("2"));
      expect(firstField.controller.text, "𝑥^2");
      await tester.tap(find.text("del"));
      expect(firstField.controller.text, "𝑥^");
      await tester.tap(find.text("3"));
      expect(firstField.controller.text, "𝑥^3");
    });

    testWidgets("input field can be cleared", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      TextField firstField = find.byType(TextField).evaluate().first.widget as TextField;
      await tester.tap(find.text("2"));
      await tester.tap(find.text("𝑥"));
      expect(firstField.controller.text, "2𝑥");
      await tester.tap(find.text("clear"));
      expect(firstField.controller.text, "");
    });

    testWidgets("a 2nd field will receive input when tapped", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text("y2= "));
      await tester.pumpAndSettle();
      TextField secondField = find.byType(TextField).evaluate().last.widget as TextField;
      await tester.tap(find.text("2"));
      await tester.tap(find.text("𝑥"));
      await tester.pumpAndSettle();
      expect(secondField.controller.text, "2𝑥");
      tester.tap(find.byIcon(Icons.remove).last);
    });

    testWidgets("able to switch between two fields", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      expect(find.byType(TextField), findsNWidgets(1)); // poop
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      TextField firstField = find.byType(TextField).evaluate().first.widget as TextField;
      TextField secondField = find.byType(TextField).evaluate().last.widget as TextField;
      await tester.tap(find.text("1"));
      await tester.tap(find.text("y2= "));
      await tester.tap(find.text("2"));
      await tester.tap(find.text("y1= "));
      await tester.tap(find.text("3"));
      expect(firstField.controller.text, "13");
      expect(secondField.controller.text, "2");
      tester.tap(find.byIcon(Icons.remove).last);
    });

    testWidgets("1st field is removed, y2 becomes y1", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      );
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text("1"));
      await tester.tap(find.text("y2= "));
      await tester.tap(find.text("2"));
      Finder removeButton1 = find.byIcon(Icons.remove).first;
      await tester.tap(removeButton1);
      await tester.pumpAndSettle();
      TextField firstField = find.byType(TextField).evaluate().first.widget as TextField;
      expect(firstField.controller.text, "2");
    });
  });


  // testing layouts
  // to generate pngs, run:  flutter test --update-goldens
  group("Layout tests", () {
    testWidgets('inital layout', (WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      ); 

      await expectLater(find.byType(FunctionScreen), matchesGoldenFile('initial.png'));
    });

    testWidgets('second field layout', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, controller, calculator)))
      ); 
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await expectLater(find.byType(FunctionScreen), matchesGoldenFile('second.png'));
    });
  });

}