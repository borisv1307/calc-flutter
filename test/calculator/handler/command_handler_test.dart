import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:test/test.dart';

class MockCalculatorDisplayController extends Mock implements CalculatorDisplayController{}
class MockVariableStorage extends Mock implements VariableStorage{}
class MockInputEvaluator extends Mock implements InputEvaluator{}

void main(){
  group('Enter',(){
    MockCalculatorDisplayController controller;
    MockInputEvaluator evaluator;
    List<DisplayHistory> history;

    setUpAll((){
      history = [];
      controller = MockCalculatorDisplayController();
      when(controller.inputItems).thenReturn([InputItem.A]);
      when(controller.history).thenReturn(history);

      evaluator = MockInputEvaluator();
      when(evaluator.evaluate([InputItem.A], history)).thenReturn(DisplayHistory([InputItem.B], '72'));

      CommandHandler handler = CommandHandler(controller, MockVariableStorage(), evaluator);
      handler.handle('enter');
    });

    test('clears input',(){
      verify(controller.clearInput()).called(1);
    });

    test('displays evaluated input',(){
      expect(history.length,1);
      expect(history[0].input,[InputItem.B]);
      expect(history[0].result,'72');
    });
  });

  group('Delete',(){
    test('deletes input',(){
      MockCalculatorDisplayController controller = MockCalculatorDisplayController();
      CommandHandler handler = CommandHandler(controller, MockVariableStorage(), MockInputEvaluator());

      handler.handle('del');
      verify(controller.delete()).called(1);
    });
  });

  group('Clear',(){
    MockCalculatorDisplayController controller;
    setUpAll((){
      controller = MockCalculatorDisplayController();
      CommandHandler handler = CommandHandler(controller, MockVariableStorage(), MockInputEvaluator());
      handler.handle('clear');
    });

    test('clears input',(){
      verify(controller.clearInput()).called(1);
    });

    test('clears history',(){
      verify(controller.clearHistory()).called(1);
    });
  });
}