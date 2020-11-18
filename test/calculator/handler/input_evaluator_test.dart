import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'file:///C:/Users/Greg/IdeaProjects/se-calc/calc-flutter/lib/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:test/test.dart';

class MockAdvancedCalculator extends Mock implements AdvancedCalculator{}

void main(){
  group('Empty input',(){
    test('evaluates to blank',(){
      InputEvaluator evaluator = InputEvaluator(MockAdvancedCalculator());

      DisplayHistory history = evaluator.evaluate([], []);
      expect(history.input,[]);
      expect(history.result, '');
    });

    test('evaluates to prior result',(){
      InputEvaluator evaluator = InputEvaluator(MockAdvancedCalculator());

      DisplayHistory history = evaluator.evaluate([], [DisplayHistory([], '3')]);
      expect(history.input,[]);
      expect(history.result, '3');
    });
  });

  group('Provided input',(){
    test('evaluates calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE], []);
      expect(history.input,[InputItem.THREE]);
      expect(history.result, '2');
    });

    test('evaluates complex input calculator result',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3+3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.THREE, InputItem.ADD, InputItem.THREE], []);
      expect(history.input,[InputItem.THREE, InputItem.ADD, InputItem.THREE]);
      expect(history.result, '2');
    });
  });

  group('Variable replacement',(){
    test('Answer is replaced with history',(){
      MockAdvancedCalculator calculator = MockAdvancedCalculator();
      when(calculator.calculate('3')).thenReturn('2');

      InputEvaluator evaluator = InputEvaluator(calculator);

      DisplayHistory history = evaluator.evaluate([InputItem.ANSWER], [DisplayHistory([], '3')]);
      expect(history.input,[InputItem.ANSWER]);
      expect(history.result, '2');
    });
  });
}