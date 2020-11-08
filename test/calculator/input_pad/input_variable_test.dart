import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

VariableStorage testVars = new VariableStorage();

void main(){

  group('variables map to correct key', (){

    test('adding a variable to the map', (){
      testVars.addVariable('1', '5 + 5');
      expect(testVars.fetchVariable('1'), equals('5 + 5'));
    });

    test('selecting correct variable from map with multiple entries', (){
      testVars.addVariable('1', '5 + 5');
      testVars.addVariable('2', '5 - 5');
      testVars.addVariable('4', '5 * 5');
      testVars.addVariable('6', '5 / 5');

      expect(testVars.fetchVariable('2'), equals('5 - 5'));
      expect(testVars.fetchVariable('6'), equals('5 / 5'));
    });

  });
}

