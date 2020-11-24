
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
    expect(InputItem.SQUARED.lookback, true);
  });

  test('open parenthesis',(){
    expect(InputItem.OPEN_PARENTHESIS.display,'(');
    expect(InputItem.OPEN_PARENTHESIS.value,'(');
  });

  test('close parenthesis',(){
    expect(InputItem.CLOSE_PARENTHESIS.display,')');
    expect(InputItem.CLOSE_PARENTHESIS.value,')');
    expect(InputItem.CLOSE_PARENTHESIS.lookback,true);
  });

  test('divide',(){
    expect(InputItem.DIVIDE.display,'÷');
    expect(InputItem.DIVIDE.value,'/');
    expect(InputItem.DIVIDE.lookback, true);
  });

  test('power',(){
    expect(InputItem.POWER.display,'^');
    expect(InputItem.POWER.value,'^');
    expect(InputItem.POWER.lookback, true);
  });

  test('multiply',(){
    expect(InputItem.MULTIPLY.display,'x');
    expect(InputItem.MULTIPLY.value,'*');
    expect(InputItem.MULTIPLY.lookback, true);
  });

  test('log',(){
    expect(InputItem.LOG.display,'log');
    expect(InputItem.LOG.value,'log(');
  });

  test('subtract',(){
    expect(InputItem.SUBTRACT.display,'−');
    expect(InputItem.SUBTRACT.value,'−');
    expect(InputItem.SUBTRACT.lookback, true);
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
    expect(InputItem.ADD.lookback, true);
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
    expect(InputItem.A.variable,true);
  });

  test('B',(){
    expect(InputItem.B.display,'B');
    expect(InputItem.B.value,'B');
    expect(InputItem.B.variable,true);
  });

  test('C',(){
    expect(InputItem.C.display,'C');
    expect(InputItem.C.value,'C');
    expect(InputItem.C.variable,true);
  });

  test('D',(){
    expect(InputItem.D.display,'D');
    expect(InputItem.D.value,'D');
    expect(InputItem.D.variable,true);
  });

  test('E',(){
    expect(InputItem.E.display,'E');
    expect(InputItem.E.value,'E');
    expect(InputItem.E.variable,true);
  });

  test('F',(){
    expect(InputItem.F.display,'F');
    expect(InputItem.F.value,'F');
    expect(InputItem.F.variable,true);
  });

  test('G',(){
    expect(InputItem.G.display,'G');
    expect(InputItem.G.value,'G');
    expect(InputItem.G.variable,true);
  });

  test('H',(){
    expect(InputItem.H.display,'H');
    expect(InputItem.H.value,'H');
    expect(InputItem.H.variable,true);
  });

  test('I',(){
    expect(InputItem.I.display,'I');
    expect(InputItem.I.value,'I');
    expect(InputItem.I.variable,true);
  });

  test('J',(){
    expect(InputItem.J.display,'J');
    expect(InputItem.J.value,'J');
    expect(InputItem.J.variable,true);
  });

  test('PI',(){
    expect(InputItem.PI.display,'𝜋');
    expect(InputItem.PI.value,'𝜋');
  });

  test('CSC',(){
    expect(InputItem.CSC.display,'sin⁻¹');
    expect(InputItem.CSC.value,'csc(');
  });

  test('E_POWER_X',(){
    expect(InputItem.E_POWER_X.display,'𝑒 ˣ');
    expect(InputItem.E_POWER_X.value,'𝑒^');
  });

  test('SINH',(){
    expect(InputItem.SINH.display,'sinh');
    expect(InputItem.SINH.value,'sinh(');
  });

  test('COSH',(){
    expect(InputItem.COSH.display,'cosh');
    expect(InputItem.COSH.value,'cosh(');
  });

  test('TANH',(){
    expect(InputItem.TANH.display,'tanh');
    expect(InputItem.TANH.value,'tanh(');
  });

  test('INVERSE',(){
    expect(InputItem.INVERSE.display,'𝑥 ⁻¹');
    expect(InputItem.INVERSE.value,'⁻¹');
  });

  test('ASIN',(){
    expect(InputItem.ASIN.display,'asin');
    expect(InputItem.ASIN.value,'asin(');
  });

  test('ACOS',(){
    expect(InputItem.ACOS.display,'acos');
    expect(InputItem.ACOS.value,'acos(');
  });

  test('ATAN',(){
    expect(InputItem.ATAN.display,'atan');
    expect(InputItem.ATAN.value,'atan(');
  });

  test('FACTORIAL',(){
    expect(InputItem.COMMA.display,',');
    expect(InputItem.COMMA.value,',');
  });

  test('ASINH',(){
    expect(InputItem.ASINH.display,'asinh');
    expect(InputItem.ASINH.value,'asinh(');
  });

  test('ACOSH',(){
    expect(InputItem.ACOSH.display,'acosh');
    expect(InputItem.ACOSH.value,'acosh(');
  });

  test('ATANH',(){
    expect(InputItem.ATANH.display,'atanh');
    expect(InputItem.ATANH.value,'atanh(');
  });

  test('storage',(){
    expect(InputItem.STORAGE.display,'sto');
    expect(InputItem.STORAGE.value,'➡');
    expect(InputItem.STORAGE.lookback,true);
  });

  test('EMPTY',(){
    expect(InputItem.EMPTY.display,'');
    expect(InputItem.EMPTY.value,'');
  });
}
