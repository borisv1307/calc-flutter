
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

void main() {
  test('ans',(){
    expect(InputItem.ANSWER.display,'Ans');
    expect(InputItem.ANSWER.value,'Ans');
  });

  test('sin',(){
    expect(InputItem.SIN.display,'sin');
    expect(InputItem.SIN.value,'sin(');
  });

  test('cos',(){
    expect(InputItem.COS.display,'cos');
    expect(InputItem.COS.value,'cos(');
  });

  test('tan',(){
    expect(InputItem.TAN.display,'tan');
    expect(InputItem.TAN.value,'tan(');
  });

  test('squared',(){
    expect(InputItem.SQUARED.display,'𝑥 ²');
    expect(InputItem.SQUARED.value,'²');
    expect(InputItem.SQUARED.answerPrepend, true);
  });

  test('open parenthesis',(){
    expect(InputItem.OPEN_PARENTHESIS.display,'(');
    expect(InputItem.OPEN_PARENTHESIS.value,'(');
  });

  test('close parenthesis',(){
    expect(InputItem.CLOSE_PARENTHESIS.display,')');
    expect(InputItem.CLOSE_PARENTHESIS.value,')');
  });

  test('divide',(){
    expect(InputItem.DIVIDE.display,'÷');
    expect(InputItem.DIVIDE.value,'/');
    expect(InputItem.DIVIDE.answerPrepend, true);
  });

  test('power',(){
    expect(InputItem.POWER.display,'^');
    expect(InputItem.POWER.value,'^');
    expect(InputItem.POWER.answerPrepend, true);
  });

  test('multiply',(){
    expect(InputItem.MULTIPLY.display,'x');
    expect(InputItem.MULTIPLY.value,'*');
    expect(InputItem.MULTIPLY.answerPrepend, true);
  });

  test('log',(){
    expect(InputItem.LOG.display,'log');
    expect(InputItem.LOG.value,'log(');
  });

  test('subtract',(){
    expect(InputItem.SUBTRACT.display,'−');
    expect(InputItem.SUBTRACT.value,'−');
    expect(InputItem.SUBTRACT.answerPrepend, true);
  });

  test('natural log',(){
    expect(InputItem.NATURAL_LOG.display,'ln');
    expect(InputItem.NATURAL_LOG.value,'ln(');
  });

  test('negative',(){
    expect(InputItem.NEGATIVE.display,'(-)');
    expect(InputItem.NEGATIVE.value,'-');
  });

  test('decimal',(){
    expect(InputItem.DECIMAL.display,'.');
    expect(InputItem.DECIMAL.value,'.');
  });

  test('add',(){
    expect(InputItem.ADD.display,'+');
    expect(InputItem.ADD.value,'+');
    expect(InputItem.ADD.answerPrepend, true);
  });

  test('zero',(){
    expect(InputItem.ZERO.display,'0');
    expect(InputItem.ZERO.value,'0');
  });

  test('one',(){
    expect(InputItem.ONE.display,'1');
    expect(InputItem.ONE.value,'1');
  });

  test('two',(){
    expect(InputItem.TWO.display,'2');
    expect(InputItem.TWO.value,'2');
  });

  test('three',(){
    expect(InputItem.THREE.display,'3');
    expect(InputItem.THREE.value,'3');
  });

  test('four',(){
    expect(InputItem.FOUR.display,'4');
    expect(InputItem.FOUR.value,'4');
  });

  test('five',(){
    expect(InputItem.FIVE.display,'5');
    expect(InputItem.FIVE.value,'5');
  });

  test('six',(){
    expect(InputItem.SIX.display,'6');
    expect(InputItem.SIX.value,'6');
  });

  test('seven',(){
    expect(InputItem.SEVEN.display,'7');
    expect(InputItem.SEVEN.value,'7');
  });

  test('eight',(){
    expect(InputItem.EIGHT.display,'8');
    expect(InputItem.EIGHT.value,'8');
  });

  test('nine',(){
    expect(InputItem.NINE.display,'9');
    expect(InputItem.NINE.value,'9');
  });

  test('A',(){
    expect(InputItem.A.display,'A');
    expect(InputItem.A.value,'A');
  });

  test('B',(){
    expect(InputItem.B.display,'B');
    expect(InputItem.B.value,'B');
  });

  test('C',(){
    expect(InputItem.C.display,'C');
    expect(InputItem.C.value,'C');
  });

  test('D',(){
    expect(InputItem.D.display,'D');
    expect(InputItem.D.value,'D');
  });

  test('E',(){
    expect(InputItem.E.display,'E');
    expect(InputItem.E.value,'E');
  });

  test('F',(){
    expect(InputItem.F.display,'F');
    expect(InputItem.F.value,'F');
  });

  test('G',(){
    expect(InputItem.G.display,'G');
    expect(InputItem.G.value,'G');
  });

  test('H',(){
    expect(InputItem.H.display,'H');
    expect(InputItem.H.value,'H');
  });

  test('I',(){
    expect(InputItem.I.display,'I');
    expect(InputItem.I.value,'I');
  });

  test('J',(){
    expect(InputItem.J.display,'J');
    expect(InputItem.J.value,'J');
  });

}