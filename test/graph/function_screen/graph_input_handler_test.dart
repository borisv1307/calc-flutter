import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_handler.dart';


class MockController extends Mock implements FunctionDisplayController{}

void main(){
  test('input is sent',(){
    MockController controller = MockController();
    GraphInputHandler handler = GraphInputHandler(controller);
    handler.handleInput(InputItem.A);
    verify(controller.input(InputItem.A)).called(1);
  });

  test('delete button',(){
    MockController controller = MockController();
    GraphInputHandler handler = GraphInputHandler(controller);
    handler.handleInput(InputItem.A);
    handler.handleCommand(CommandItem.DELETE);
    verify(controller.delete()).called(1);
  });

  test('clear button',(){
    MockController controller = MockController();
    GraphInputHandler handler = GraphInputHandler(controller);
    handler.handleInput(InputItem.A);
    handler.handleCommand(CommandItem.CLEAR);
    verify(controller.clearInput()).called(1);
  });
}

