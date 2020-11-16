
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

void main() {
  test('sin',(){
    expect(InputItem.SIN.display,'sin');
    expect(InputItem.SIN.value,'sin(');
    expect(InputItem.SIN.catalog,true);
  });

  test('cos',(){
    expect(InputItem.COS.display,'cos');
    expect(InputItem.COS.value,'cos(');
    expect(InputItem.COS.catalog,true);
  });

  test('tan',(){
    expect(InputItem.TAN.display,'tan');
    expect(InputItem.TAN.value,'tan(');
    expect(InputItem.TAN.catalog,true);
  });

  test('squared',(){
    expect(InputItem.SQUARED.display,'𝑥 ²');
    expect(InputItem.SQUARED.value,'²');
    expect(InputItem.SQUARED.catalog,true);
  });

  test('open parenthesis',(){
    expect(InputItem.OPEN_PARENTHESIS.display,'(');
    expect(InputItem.OPEN_PARENTHESIS.value,'(');
    expect(InputItem.OPEN_PARENTHESIS.catalog,true);
  });

  test('close parenthesis',(){
    expect(InputItem.CLOSE_PARENTHESIS.display,')');
    expect(InputItem.CLOSE_PARENTHESIS.value,')');
    expect(InputItem.CLOSE_PARENTHESIS.catalog,true);
  });

  test('divide',(){
    expect(InputItem.DIVIDE.display,'÷');
    expect(InputItem.DIVIDE.value,'/');
    expect(InputItem.DIVIDE.catalog,true);
  });

  test('power',(){
    expect(InputItem.POWER.display,'^');
    expect(InputItem.POWER.value,'^');
    expect(InputItem.POWER.catalog,true);
  });

  test('multiply',(){
    expect(InputItem.MULTIPLY.display,'x');
    expect(InputItem.MULTIPLY.value,'*');
    expect(InputItem.MULTIPLY.catalog,true);
  });

  test('log',(){
    expect(InputItem.LOG.display,'log');
    expect(InputItem.LOG.value,'log(');
    expect(InputItem.LOG.catalog,true);
  });

  test('subtract',(){
    expect(InputItem.SUBTRACT.display,'-');
    expect(InputItem.SUBTRACT.value,'−');
    expect(InputItem.SUBTRACT.catalog,true);
  });

  test('natural log',(){
    expect(InputItem.NATURAL_LOG.display,'ln');
    expect(InputItem.NATURAL_LOG.value,'ln(');
    expect(InputItem.NATURAL_LOG.catalog,true);
  });

  test('negative',(){
    expect(InputItem.NEGATIVE.display,'(-)');
    expect(InputItem.NEGATIVE.value,'-');
    expect(InputItem.NEGATIVE.catalog,true);
  });

  test('decimal',(){
    expect(InputItem.DECIMAL.display,'.');
    expect(InputItem.DECIMAL.value,'.');
    expect(InputItem.DECIMAL.catalog,true);
  });

  test('add',(){
    expect(InputItem.ADD.display,'+');
    expect(InputItem.ADD.value,'+');
    expect(InputItem.ADD.catalog,true);
  });

  test('zero',(){
    expect(InputItem.ZERO.display,'0');
    expect(InputItem.ZERO.value,'0');
    expect(InputItem.ZERO.catalog,false);
  });

  test('one',(){
    expect(InputItem.ONE.display,'1');
    expect(InputItem.ONE.value,'1');
    expect(InputItem.ONE.catalog,false);
  });

  test('two',(){
    expect(InputItem.TWO.display,'2');
    expect(InputItem.TWO.value,'2');
    expect(InputItem.TWO.catalog,false);
  });

  test('three',(){
    expect(InputItem.THREE.display,'3');
    expect(InputItem.THREE.value,'3');
    expect(InputItem.THREE.catalog,false);
  });

  test('four',(){
    expect(InputItem.FOUR.display,'4');
    expect(InputItem.FOUR.value,'4');
    expect(InputItem.FOUR.catalog,false);
  });

  test('five',(){
    expect(InputItem.FIVE.display,'5');
    expect(InputItem.FIVE.value,'5');
    expect(InputItem.FIVE.catalog,false);
  });

  test('six',(){
    expect(InputItem.SIX.display,'6');
    expect(InputItem.SIX.value,'6');
    expect(InputItem.SIX.catalog,false);
  });

  test('seven',(){
    expect(InputItem.SEVEN.display,'7');
    expect(InputItem.SEVEN.value,'7');
    expect(InputItem.SEVEN.catalog,false);
  });

  test('eight',(){
    expect(InputItem.EIGHT.display,'8');
    expect(InputItem.EIGHT.value,'8');
    expect(InputItem.EIGHT.catalog,false);
  });

  test('nine',(){
    expect(InputItem.NINE.display,'9');
    expect(InputItem.NINE.value,'9');
    expect(InputItem.NINE.catalog,false);
  });

  test('A',(){
    expect(InputItem.A.display,'A');
    expect(InputItem.A.value,'A');
    expect(InputItem.A.catalog,false);
  });

  test('B',(){
    expect(InputItem.B.display,'B');
    expect(InputItem.B.value,'B');
    expect(InputItem.B.catalog,false);
  });

  test('C',(){
    expect(InputItem.C.display,'C');
    expect(InputItem.C.value,'C');
    expect(InputItem.C.catalog,false);
  });

  test('D',(){
    expect(InputItem.D.display,'D');
    expect(InputItem.D.value,'D');
    expect(InputItem.D.catalog,false);
  });

  test('E',(){
    expect(InputItem.E.display,'E');
    expect(InputItem.E.value,'E');
    expect(InputItem.E.catalog,false);
  });

  test('F',(){
    expect(InputItem.F.display,'F');
    expect(InputItem.F.value,'F');
    expect(InputItem.F.catalog,false);
  });

  test('G',(){
    expect(InputItem.G.display,'G');
    expect(InputItem.G.value,'G');
    expect(InputItem.G.catalog,false);
  });

  test('H',(){
    expect(InputItem.H.display,'H');
    expect(InputItem.H.value,'H');
    expect(InputItem.H.catalog,false);
  });

  test('I',(){
    expect(InputItem.I.display,'I');
    expect(InputItem.I.value,'I');
    expect(InputItem.I.catalog,false);
  });

  test('J',(){
    expect(InputItem.J.display,'J');
    expect(InputItem.J.value,'J');
    expect(InputItem.J.catalog,false);
  });

}