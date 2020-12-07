import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/function_screen.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_pad.dart';


void main() {

  VariableStorage storage = VariableStorage();

  FunctionDisplayController _buildController() {
    return FunctionDisplayController(storage);
  }

  // for testing widget behavior
  group("Widget tests", () {
    testWidgets("function screen can be created", (WidgetTester tester) async {
      // pump the widget wrapped in a MaterialApp Scaffold
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(VariableStorage(), _buildController())))
      );
      // use a finder to find the widget
      Finder screenFinder = find.byType(FunctionScreen);

      // use a matcher to ensure it is found
      expect(screenFinder, findsNWidgets(1));
    });

    testWidgets("function screen begins with 1 input field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      );
      expect(find.byType(FunctionTextField), findsNWidgets(1));
    });

    testWidgets("function screen has input pad", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      );
      expect(find.byType(GraphInputPad), findsNWidgets(1));
    });

    testWidgets("+ button adds input field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
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
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      ); 
      expect(find.byIcon(Icons.remove), findsNWidgets(2));
    });

    testWidgets("remove button removes 2nd text field", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      ); 
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

  // for testing layouts
  // to generate pngs, run:  flutter test --update-goldens
  group("Layout tests", () {
    testWidgets('inital layout', (WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      ); 

      await expectLater(find.byType(FunctionScreen), matchesGoldenFile('initial.png'));
    });

    testWidgets('second field layout', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FunctionScreen(storage, _buildController())))
      ); 
      Finder addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await expectLater(find.byType(FunctionScreen), matchesGoldenFile('second.png'));
    });
  });

}