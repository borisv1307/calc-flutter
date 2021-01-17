import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';

class TestableFunctionDisplayController extends FunctionDisplayController{

  TestableFunctionDisplayController(storage) : super(storage);
  int notified = 0;

  @override
  void notifyListeners(){
    notified++;
  }
}

void main(){

  test('begins with one field',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    expect(controller.inputs, [[]]);
  });

  test('can be added to a field',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.input(InputItem.X);
    expect(controller.inputs, [[InputItem.X]]);
  });

  test('notifies listeners when updated',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.input(InputItem.X);
    expect(controller.notified, 1);
  });

  test('field can be cleared',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.input(InputItem.X);
    controller.clearInput();
    expect(controller.notified, 2);
    expect(controller.inputs, [[]]);
  });

  test('can be deleted',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.input(InputItem.TWO);
    controller.input(InputItem.X);
    controller.delete();
    expect(controller.notified, 3);
    expect(controller.inputs, [[InputItem.TWO]]);
  });

  test('can be returned as string',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.input(InputItem.TWO);
    controller.input(InputItem.X);
    expect(controller.notified, 2);
    expect(controller.getInput(0), "2x");
  });

  test('new field can be added',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.addField();
    expect(controller.inputs, [[], []]);
  });

  test('active field begins as 0',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.addField();
    expect(controller.currentField, 0);
  });

  test('active field can be changed and receive input',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.addField();
    controller.currentField = 1;
    controller.input(InputItem.X);
    expect(controller.inputs, [[], [InputItem.X]]);
  });

  test('field can be removed, preserves other fields',() {
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(VariableStorage());
    controller.addField();
    controller.currentField = 1;
    controller.input(InputItem.X);
    controller.removeField(0);
    expect(controller.inputs, [[InputItem.X]]);
  });

  test('variables are translated',() {
    VariableStorage storage = VariableStorage();
    storage.addVariable("A", "123");
    TestableFunctionDisplayController controller = TestableFunctionDisplayController(storage);
    controller.input(InputItem.A);
    controller.input(InputItem.ADD);
    controller.input(InputItem.X);
    expect(controller.translateInputs(), ["123+x"]);
  });
}

