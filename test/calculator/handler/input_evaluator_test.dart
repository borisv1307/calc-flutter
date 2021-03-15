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
final List<List<List<String>>> matrixStorage = [
  
  [['1','2'],['1','2']],
  [['2','3'],['2','3']]
  
  ];
void main(){
  group('Empty input',(){
    test('evaluates when no history',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('', options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([], [], options);
      expect(history.input,[]);
      expect(history.result, '4');
    });

    test('evaluates prior input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('7', options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

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

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE], [],options);
      expect(history.input,[InputItem.THREE]);
      expect(history.evaluatedInput,[InputItem.THREE]);
      expect(history.result, '2');
    });

    test('evaluates complex input calculator result',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+3',options)).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

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

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.ANSWER]);
      expect(history.result, '2');
    });

    test('Answer is multiplied with next input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3*2',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER, InputItem.TWO], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.ANSWER, InputItem.TWO]);
      expect(history.result, '4');
    });

    test('Answer is multiplied with prior input',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('2*3',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.TWO, InputItem.ANSWER], [DisplayHistory([], '3')],options);
      expect(history.input,[InputItem.TWO, InputItem.ANSWER]);
      expect(history.result, '4');
    });

    test('Answer is only multiplied with next input if next input isnt a lookback',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+2',options)).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

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

        InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);
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

        InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);
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

        InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);
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

      InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);

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

      InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);

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

      InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);

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

      InputEvaluator evaluator = InputEvaluator(storage, matrixStorage, calculator);

      DisplayHistory output = evaluator.evaluate([InputItem.LOG, InputItem.A], [],options);

      expect(output.input,[InputItem.LOG, InputItem.A]);
      expect(output.result,'1');
    });
  });

  group('Matrix Evaluation',(){

    test('addition is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('&1;2@1;2\$+&2;3@2;3\$')).thenReturn('&3;5@3;5\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem('matr1'), InputItem.ADD, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr3');
      expect(matrixStorage[2], [['3','5'],['3','5']]);
    });
    test('subtraction is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('&1;2@1;2\$-&2;3@2;3\$')).thenReturn('&-1;-1@-1;-1\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem('matr1'), InputItem.SUBTRACT, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr4');
      expect(matrixStorage[3], [['-1','-1'],['-1','-1']]);
    });

    test('multiplication is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('&1;2@1;2\$*&2;3@2;3\$')).thenReturn('&6;9@6;9\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem('matr1'), InputItem.MULTIPLY, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr5');
      expect(matrixStorage[4], [['6','9'],['6','9']]);
    });

    test('division is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('&1;2@1;2\$/&2;3@2;3\$')).thenReturn('&2;-1.5@2;-1.5\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem('matr1'), InputItem.DIVIDE, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr6');
      expect(matrixStorage[5], [['2','-1.5'],['2','-1.5']]);
    });

    test('determinant is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('determinant(&1;2@1;2\$)')).thenReturn('0');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.DETERMINANT, InputItem('matr1')], [],options);
      expect(history.result, '0');
    });

    test('permanent is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('permanent(&1;2@1;2\$)')).thenReturn('4');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.PERMANENT, InputItem('matr1')], [],options);
      expect(history.result, '4');
    });

    test('transpose is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('transpose(&2;3@2;3\$)')).thenReturn('&2;2@3;3\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.TRANSPOSE, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr7');
      expect(matrixStorage[6], [['2','2'],['3','3']]);
    });

    test('inverse is evaluated correctly',(){
      CalculationOptions options = CalculationOptions();
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculateMatrix('inverse(&2;3@2;3\$)')).thenReturn('&0;0.5@1;-1\$');

      InputEvaluator evaluator = InputEvaluator(MockVariableStorage(), matrixStorage, calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.MATR_INVERSE, InputItem('matr2')], [],options);
      expect(history.result, 'Results stored in matr8');
      expect(matrixStorage[7], [['0','0.5'],['1','-1']]);
    });
  });
}