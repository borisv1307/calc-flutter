import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:test/test.dart';

class MockAdvancedCalculator extends Mock implements AdvancedCalculator{}
class MockVariableStorage extends Mock implements VariableStorage{}

void main(){
  group('Empty input',(){
    test('evaluates to blank',(){
      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),MockAdvancedCalculator());

      DisplayHistory history = evaluator.evaluate([], []);
      expect(history.input,[]);
      expect(history.result, '');
    });

    test('evaluates to prior result',(){
      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),MockAdvancedCalculator());

      DisplayHistory history = evaluator.evaluate([], [DisplayHistory([], '3')]);
      expect(history.input,[]);
      expect(history.result, '3');
    });
  });

  group('Provided input',(){
    test('evaluates calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE], []);
      expect(history.input,[InputItem.THREE]);
      expect(history.result, '2');
    });

    test('evaluates complex input calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE, InputItem.ADD, InputItem.THREE], []);
      expect(history.input,[InputItem.THREE, InputItem.ADD, InputItem.THREE]);
      expect(history.result, '2');
    });
  });

  group('Variable replacement',(){
    test('Answer is replaced with history',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER]);
      expect(history.result, '2');
    });

    test('Answer is multiplied with next input',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2')).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.TWO], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER, InputItem.TWO]);
      expect(history.result, '4');
    });

    test('Answer is only multiplied with next input if next input isnt a lookback',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+2')).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.ADD, InputItem.TWO], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER, InputItem.ADD, InputItem.TWO]);
      expect(history.result, '4');
    });
  });

  group('Variable storage',(){
    group('with variable specified',(){
      MockVariableStorage storage;
      DisplayHistory history;

      setUp((){
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3')).thenReturn('2');

        storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        history = evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.A], []);
      });

      test('stores variable',(){
        verify(storage.addVariable('A', '2'));
      });

      test('displays input',(){
        expect(history.input,[InputItem.THREE,InputItem.STORAGE,InputItem.A]);
      });

      test('displays result',(){
        expect(history.result,'2');
      });
    });

    group('with non variable specified',(){
      MockVariableStorage storage;
      DisplayHistory history;

      setUp((){
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3')).thenReturn('2');

        storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        history = evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR], []);
      });

      test('does not store variable',(){
        verifyNoMoreInteractions(storage);
      });

      test('displays input',(){
        expect(history.input,[InputItem.THREE,InputItem.STORAGE,InputItem.FOUR]);
      });

      test('displays syntax error',(){
        expect(history.result,'Syntax Error');
      });
    });

    group('with multiple characters specified for storage',(){
      MockVariableStorage storage;
      DisplayHistory history;

      setUp((){
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3')).thenReturn('2');

        storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        history = evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR, InputItem.A], []);
      });

      test('does not store variable',(){
        verifyNoMoreInteractions(storage);
      });

      test('displays input',(){
        expect(history.input,[InputItem.THREE,InputItem.STORAGE,InputItem.FOUR, InputItem.A]);
      });

      test('displays syntax error',(){
        expect(history.result,'Syntax Error');
      });
    });
  });

  group('Variable retrieval',(){
    test('Variable replacement',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3')).thenReturn('2');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A], []);

      expect(output.input,[InputItem.A]);
      expect(output.result,'2');
    });

    test('Variable multiplication',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2')).thenReturn('6');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A, InputItem.TWO], []);

      expect(output.input,[InputItem.A, InputItem.TWO]);
      expect(output.result,'6');
    });
  });
}