import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_handler.dart';


class MockController extends Mock implements FunctionDisplayController{}

class MockContext extends Mock implements BuildContext{}


void main() {
  test('input is sent',(){
    MockController controller = MockController();
    MockContext context = MockContext();
    GlobalKey formKey = GlobalKey<FormState>();
    
    GraphInputHandler handler = GraphInputHandler(controller, context, formKey);
    try {
      handler.handleInput(InputItem.A); 
    } catch (NoSuchMethodError) { }  // for SettingsController.of(context)
    verify(controller.input(InputItem.A)).called(1);
  });

  test('delete button',(){
    MockController controller = MockController();
    MockContext context = MockContext();
    GlobalKey formKey = GlobalKey<FormState>();

    GraphInputHandler handler = GraphInputHandler(controller, context, formKey);
    try {
      handler.handleCommand(CommandItem.DELETE);
    } catch (NoSuchMethodError) { }  // for SettingsController.of(context)
    verify(controller.delete()).called(1);
  });

  test('clear button',(){
    MockController controller = MockController();
    MockContext context = MockContext();
    GlobalKey formKey = GlobalKey<FormState>();

    GraphInputHandler handler = GraphInputHandler(controller, context, formKey);
    try {
      handler.handleCommand(CommandItem.CLEAR);
    } catch (NoSuchMethodError) { }  // for SettingsController.of(context)

    verify(controller.clearInput()).called(1);
  });
}

