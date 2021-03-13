import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/settings/variable_storage.dart';

VariableStorage testVars = new VariableStorage();

void main(){

  group('variables map to correct key', (){

    test('adding a variable to the map', (){
      testVars.setVariable('1', '5 + 5');
      expect(testVars.getVariable('1'), equals('5 + 5'));
    });

    test('selecting correct variable from map with multiple entries', (){
      testVars.setVariable('1', '5 + 5');
      testVars.setVariable('2', '5 - 5');
      testVars.setVariable('4', '5 * 5');
      testVars.setVariable('6', '5 / 5');

      expect(testVars.getVariable('2'), equals('5 - 5'));
      expect(testVars.getVariable('6'), equals('5 / 5'));
    });
  });

  test('Non existent variable returns 0',(){
    VariableStorage storage = new VariableStorage();
    expect(storage.getVariable('Z'),'0');
  });
}

