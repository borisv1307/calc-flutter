import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/syntax_exception.dart';
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
    test('evaluates when no history',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('', options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([], [], options);
      expect(history.input,[]);
      expect(history.result, '4');
    });

    test('evaluates prior input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('7', options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([], [DisplayHistory([InputItem.SEVEN], '3')], options);
      expect(history.input,[]);
      expect(history.evaluatedInput,[InputItem.SEVEN]);
      expect(history.result, '4');
    });
  });

  group('Provided input',(){
    test('evaluates calculator result',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',options)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE], [],options);
      expect(history.input,[InputItem.THREE]);
      expect(history.evaluatedInput,[InputItem.THREE]);
      expect(history.result, '2');
    });

    test('evaluates complex input calculator result',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+3',options)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE, InputItem.ADD, InputItem.THREE], [],options);
      expect(history.input,[InputItem.THREE, InputItem.ADD, InputItem.THREE]);
      expect(history.result, '2');
    });
  });

  group('Variable replacement',(){
    test('Answer is replaced with history',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',options)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.ANSWER]);
      expect(history.result, '2');
    });

    test('Answer is multiplied with next input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.TWO], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.ANSWER, InputItem.TWO]);
      expect(history.result, '4');
    });

    test('Answer is multiplied with prior input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('2*3',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.TWO, InputItem.ANSWER], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.TWO, InputItem.ANSWER]);
      expect(history.result, '4');
    });

    test('Answer is only multiplied with next input if next input isnt a lookback',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+2',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.ADD, InputItem.TWO], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.ANSWER, InputItem.ADD, InputItem.TWO]);
      expect(history.result, '4');
    });
  });

  group('Variable storage',(){
    group('with variable specified',(){
      MockVariableStorage storage;
      DisplayHistory history;

      setUp((){
        CalculationOptions options = CalculationOptions();
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',options)).thenReturn('2');

        storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        history = evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.A], [],options);
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
      triggerSyntaxException(){
        CalculationOptions options = CalculationOptions();
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',options)).thenReturn('2');

        MockVariableStorage storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR], [],options);
      }

      test('throws syntax exception',(){
        expect(() => triggerSyntaxException(), throwsA(const TypeMatcher<SyntaxException>()));
      });

      test('sets syntax error index',(){
        try{
          triggerSyntaxException();
        }on SyntaxException catch(e){
          expect(e.index, 2);
        }
      });
    });

    group('with multiple characters specified for storage',(){

      triggerSyntaxException(){
        CalculationOptions options = CalculationOptions();
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',options)).thenReturn('2');

        MockVariableStorage storage = MockVariableStorage();

        InputEvaluator evaluator = InputEvaluator(storage,calculator);
        evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR, InputItem.A], [],options);
      }

      test('throws syntax exception',(){
        expect(() => triggerSyntaxException(), throwsA(const TypeMatcher<SyntaxException>()));
      });

      test('sets syntax error index',(){
        try{
          triggerSyntaxException();
        }on SyntaxException catch(e){
          expect(e.index, 2);
        }
      });
    });
  });

  group('Variable retrieval',(){
    test('Variable replacement',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',options)).thenReturn('2');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A], [],options);

      expect(output.input,[InputItem.A]);
      expect(output.result,'2');
    });

    test('Variable multiplication after',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2',options)).thenReturn('6');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A, InputItem.TWO], [],options);

      expect(output.input,[InputItem.A, InputItem.TWO]);
      expect(output.result,'6');
    });

    test('Variable multiplication before',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('2*3',options)).thenReturn('6');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.TWO, InputItem.A], [],options);

      expect(output.input,[InputItem.TWO, InputItem.A]);
      expect(output.result,'6');
    });

    test('Variable in function does not add multiplication',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('log(10',options)).thenReturn('1');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('10');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.LOG, InputItem.A], [],options);

      expect(output.input,[InputItem.LOG, InputItem.A]);
      expect(output.result,'1');
    });

    test('Negative variable is translated',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('`5',options)).thenReturn('-5');

      MockVariableStorage storage = MockVariableStorage();
      when(storage.fetchVariable('A')).thenReturn('-5');

      InputEvaluator evaluator = InputEvaluator(storage,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A], [],options);

      expect(output.input,[InputItem.A]);
      expect(output.result,'-5');
    });

    test('Negative answer is translated',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('`8',options)).thenReturn('-8');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(),calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.ANSWER],[DisplayHistory([], '-8')],options);

      expect(output.input,[InputItem.ANSWER]);
      expect(output.result,'-8');
    });
  });
}
