import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/syntax_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:test/test.dart';

class MockCalculatorDisplayController extends Mock implements CalculatorDisplayController{
  int cursorIndex;
}
class MockVariableStorage extends Mock implements VariableStorage{}
class MockInputEvaluator extends Mock implements InputEvaluator{}
class MockSettingsController extends Mock implements SettingsController{}

void main(){
  group('Enter',(){
    group('Valid input',(){
      MockCalculatorDisplayController controller;
      MockInputEvaluator evaluator;
      List<DisplayHistory> history;
      SettingsController settings;

      setUpAll((){
        CalculationOptions options;
        history = [];
        settings = MockSettingsController();

        controller = MockCalculatorDisplayController();
        when(controller.inputItems).thenReturn([InputItem.A]);
        when(controller.history).thenReturn(history);

        evaluator = MockInputEvaluator();
        when(evaluator.evaluate([InputItem.A], history, options)).thenReturn(DisplayHistory([InputItem.B], '72'));

        CommandHandler handler = CommandHandler(controller, MockVariableStorage(), settings, evaluator);
        handler.handle(CommandItem.ENTER);
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

    group('Syntax error',(){
      MockCalculatorDisplayController controller;
      MockInputEvaluator evaluator;
      List<DisplayHistory> history;
      SettingsController settings;

      setUpAll((){
        CalculationOptions options;
        history = [];
        settings = MockSettingsController();

        controller = MockCalculatorDisplayController();
        when(controller.inputItems).thenReturn([InputItem.A]);
        when(controller.history).thenReturn(history);

        evaluator = MockInputEvaluator();
        when(evaluator.evaluate([InputItem.A], history,options)).thenThrow(new SyntaxException(1));

        CommandHandler handler = CommandHandler(controller, MockVariableStorage(), settings, evaluator);
        handler.handle(CommandItem.ENTER);
      });

      test('pushes syntax alert',(){
        verify(controller.pushAlert('Syntax Error')).called(1);
      });

      test('moves cursor to location of error',(){
        expect(controller.cursorIndex, 1);
      });
    });
  });

  group('Delete',(){
    test('deletes input',(){
      MockCalculatorDisplayController controller = MockCalculatorDisplayController();
      CommandHandler handler = CommandHandler(controller, MockVariableStorage(), MockSettingsController(), MockInputEvaluator());

      handler.handle(CommandItem.DELETE);
      verify(controller.delete()).called(1);
    });
  });

  group('Clear',(){
    MockCalculatorDisplayController controller;
    setUpAll((){
      controller = MockCalculatorDisplayController();
      CommandHandler handler = CommandHandler(controller, MockVariableStorage(), MockSettingsController(), MockInputEvaluator());
      handler.handle(CommandItem.CLEAR);
    });

    test('clears input',(){
      verify(controller.clearInput()).called(1);
    });

    test('clears history',(){
      verify(controller.clearHistory()).called(1);
    });
  });
}