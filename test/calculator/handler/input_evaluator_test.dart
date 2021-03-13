import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:advanced_calculation/syntax_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:test/test.dart';

class MockAdvancedCalculator extends Mock implements AdvancedCalculator{}
class MockSettingsController extends Mock implements SettingsController{}

void main(){
  group('Empty input',(){
    test('evaluates when no history',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('', any)).thenReturn('4');
      
      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([], []);
      expect(history.input,[]);
      expect(history.result, '4');
    });

    test('evaluates prior input',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('7', any)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([], [DisplayHistory([InputItem.SEVEN], '3')]);
      expect(history.input,[]);
      expect(history.evaluatedInput,[InputItem.SEVEN]);
      expect(history.result, '4');
    });
  });

  group('Provided input',(){
    test('evaluates calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',any)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE], []);
      expect(history.input,[InputItem.THREE]);
      expect(history.evaluatedInput,[InputItem.THREE]);
      expect(history.result, '2');
    });

    test('evaluates complex input calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+3',any)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE, InputItem.ADD, InputItem.THREE], []);
      expect(history.input,[InputItem.THREE, InputItem.ADD, InputItem.THREE]);
      expect(history.result, '2');
    });
  });

  group('Variable replacement',(){
    test('Answer is replaced with history',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',any)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER]);
      expect(history.result, '2');
    });

    test('Answer is multiplied with next input',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2',any)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.TWO], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER, InputItem.TWO]);
      expect(history.result, '4');
    });

    test('Answer is multiplied with prior input',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('2*3',any)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.TWO, InputItem.ANSWER], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.TWO, InputItem.ANSWER]);
      expect(history.result, '4');
    });

    test('Answer is only multiplied with next input if next input isnt a lookback',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+2',any)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.ADD, InputItem.TWO], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER, InputItem.ADD, InputItem.TWO]);
      expect(history.result, '4');
    });
  });

  group('Variable settings',(){
    group('with variable specified',(){
      MockSettingsController settings;
      DisplayHistory history;

      setUp((){
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',any)).thenReturn('2');

        settings = MockSettingsController();

        InputEvaluator evaluator = InputEvaluator(settings,calculator);
        history = evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.A], []);
      });

      test('stores variable',(){
        verify(settings.storeVariable('A', '2'));
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
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',any)).thenReturn('2');

        MockSettingsController settings = MockSettingsController();

        InputEvaluator evaluator = InputEvaluator(settings,calculator);
        evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR], []);
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

    group('with multiple characters specified for settings',(){

      triggerSyntaxException(){
        MockAdvancedCalculator calculator = MockAdvancedCalculator();
        when(calculator.calculate('3',any)).thenReturn('2');

        MockSettingsController settings = MockSettingsController();

        InputEvaluator evaluator = InputEvaluator(settings,calculator);
        evaluator.evaluate([InputItem.THREE,InputItem.STORAGE,InputItem.FOUR, InputItem.A], []);
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
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3',any)).thenReturn('2');

      MockSettingsController settings = MockSettingsController();
      when(settings.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(settings,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A], []);

      expect(output.input,[InputItem.A]);
      expect(output.result,'2');
    });

    test('Variable multiplication after',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2',any)).thenReturn('6');

      MockSettingsController settings = MockSettingsController();
      when(settings.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(settings,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A, InputItem.TWO], []);

      expect(output.input,[InputItem.A, InputItem.TWO]);
      expect(output.result,'6');
    });

    test('Variable multiplication before',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('2*3',any)).thenReturn('6');

      MockSettingsController settings = MockSettingsController();
      when(settings.fetchVariable('A')).thenReturn('3');

      InputEvaluator evaluator = InputEvaluator(settings,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.TWO, InputItem.A], []);

      expect(output.input,[InputItem.TWO, InputItem.A]);
      expect(output.result,'6');
    });

    test('Variable in function does not add multiplication',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('log(10',any)).thenReturn('1');

      MockSettingsController settings = MockSettingsController();
      when(settings.fetchVariable('A')).thenReturn('10');

      InputEvaluator evaluator = InputEvaluator(settings,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.LOG, InputItem.A], []);

      expect(output.input,[InputItem.LOG, InputItem.A]);
      expect(output.result,'1');
    });

    test('Negative variable is translated',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('`5',any)).thenReturn('-5');

      MockSettingsController settings = MockSettingsController();
      when(settings.fetchVariable('A')).thenReturn('-5');

      InputEvaluator evaluator = InputEvaluator(settings,calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.A], []);

      expect(output.input,[InputItem.A]);
      expect(output.result,'-5');
    });

    test('Negative answer is translated',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('`8',any)).thenReturn('-8');

      InputEvaluator evaluator = InputEvaluator(MockSettingsController(),calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.ANSWER],[DisplayHistory([], '-8')]);

      expect(output.input,[InputItem.ANSWER]);
      expect(output.result,'-8');
    });
  });
}
