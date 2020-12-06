import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';

void main() {

  testWidgets("text field can be created", (WidgetTester tester) async {
    // pump the widget wrapped in a MaterialApp Scaffold
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FunctionTextField(0, FunctionDisplayController())
      )
    ));
    // use a finder to find the widget
    Finder fieldFinder = find.byType(FunctionTextField);
    // use a matcher to ensure it is found
    expect(fieldFinder, findsOneWidget);
  });














}



class FunctionFieldWrapper extends StatelessWidget {
  final int index;
  final FunctionDisplayController controller;
  
  FunctionFieldWrapper(this.index) : 
    controller = new FunctionDisplayController();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: FunctionTextField(index, controller))
    );
  }
}