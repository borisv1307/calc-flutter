
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

void main() {
  test('ans',(){
    expect(InputItem.ANSWER.label,'Ans');
    expect(InputItem.ANSWER.display,'Ans');
    expect(InputItem.ANSWER.value,'Ans');
  });

  test('sin',(){
    expect(InputItem.SIN.label,'sin');
    expect(InputItem.SIN.display,'sin(');
    expect(InputItem.SIN.value,'sin(');
    expect(InputItem.SIN.function, true);
  });

  test('cos',(){
    expect(InputItem.COS.label,'cos');
    expect(InputItem.COS.display,'cos(');
    expect(InputItem.COS.value,'cos(');
    expect(InputItem.COS.function, true);
  });

  test('tan',(){
    expect(InputItem.TAN.label,'tan');
    expect(InputItem.TAN.display,'tan(');
    expect(InputItem.TAN.value,'tan(');
    expect(InputItem.TAN.function, true);
  });

  test('squared',(){
    expect(InputItem.SQUARED.label,'𝑥 ²');
    expect(InputItem.SQUARED.display,'²');
    expect(InputItem.SQUARED.value,'²');
    expect(InputItem.SQUARED.lookback, true);
    expect(InputItem.SQUARED.name, 'square');
  });

    test('square root',(){
    expect(InputItem.SQUARE_ROOT.label,'sqrt');
    expect(InputItem.SQUARE_ROOT.display,'√(');
    expect(InputItem.SQUARE_ROOT.value,'√(');
    expect(InputItem.SQUARE_ROOT.function, true);
  });


  test('open parenthesis',(){
    expect(InputItem.OPEN_PARENTHESIS.label,'(');
    expect(InputItem.OPEN_PARENTHESIS.display,'(');
    expect(InputItem.OPEN_PARENTHESIS.value,'(');
  });

  test('close parenthesis',(){
    expect(InputItem.CLOSE_PARENTHESIS.label,')');
    expect(InputItem.CLOSE_PARENTHESIS.display,')');
    expect(InputItem.CLOSE_PARENTHESIS.value,')');
    expect(InputItem.CLOSE_PARENTHESIS.lookback,true);
  });

  test('divide',(){
    expect(InputItem.DIVIDE.label,'÷');
    expect(InputItem.DIVIDE.display,'/');
    expect(InputItem.DIVIDE.value,'/');
    expect(InputItem.DIVIDE.lookback, true);
    expect(InputItem.DIVIDE.name,'divide');
  });

  test('power',(){
    expect(InputItem.POWER.label,'^');
    expect(InputItem.POWER.display,'^');
    expect(InputItem.POWER.value,'^');
    expect(InputItem.POWER.lookback, true);
    expect(InputItem.POWER.name,'power');
  });

  test('multiply',(){
    expect(InputItem.MULTIPLY.label,'x');
    expect(InputItem.MULTIPLY.display,'*');
    expect(InputItem.MULTIPLY.value,'*');
    expect(InputItem.MULTIPLY.lookback, true);
    expect(InputItem.MULTIPLY.name, 'multiply');
  });

  test('log',(){
    expect(InputItem.LOG.label,'log');
    expect(InputItem.LOG.display,'log(');
    expect(InputItem.LOG.value,'log(');
    expect(InputItem.LOG.function, true);
  });

  test('subtract',(){
    expect(InputItem.SUBTRACT.label,'—');
    expect(InputItem.SUBTRACT.display,'—');
    expect(InputItem.SUBTRACT.value,'-');
    expect(InputItem.SUBTRACT.lookback, true);
    expect(InputItem.SUBTRACT.name, 'subtract');
  });

  test('natural log',(){
    expect(InputItem.NATURAL_LOG.label,'ln');
    expect(InputItem.NATURAL_LOG.display,'ln(');
    expect(InputItem.NATURAL_LOG.value,'ln(');
    expect(InputItem.NATURAL_LOG.function, true);
  });

  test('negative',(){
    expect(InputItem.NEGATIVE.label,'(-)');
    expect(InputItem.NEGATIVE.display,'-');
    expect(InputItem.NEGATIVE.value,'`');
  });

  test('decimal',(){
    expect(InputItem.DECIMAL.label,'.');
    expect(InputItem.DECIMAL.display,'.');
    expect(InputItem.DECIMAL.value,'.');
  });

  test('add',(){
    expect(InputItem.ADD.label,'+');
    expect(InputItem.ADD.display,'+');
    expect(InputItem.ADD.value,'+');
    expect(InputItem.ADD.lookback, true);
    expect(InputItem.ADD.name,'add');
  });

  test('zero',(){
    expect(InputItem.ZERO.label,'0');
    expect(InputItem.ZERO.display,'0');
    expect(InputItem.ZERO.value,'0');
  });

  test('one',(){
    expect(InputItem.ONE.label,'1');
    expect(InputItem.ONE.display,'1');
    expect(InputItem.ONE.value,'1');
  });

  test('two',(){
    expect(InputItem.TWO.label,'2');
    expect(InputItem.TWO.display,'2');
    expect(InputItem.TWO.value,'2');
  });

  test('three',(){
    expect(InputItem.THREE.label,'3');
    expect(InputItem.THREE.display,'3');
    expect(InputItem.THREE.value,'3');
  });

  test('four',(){
    expect(InputItem.FOUR.label,'4');
    expect(InputItem.FOUR.display,'4');
    expect(InputItem.FOUR.value,'4');
  });

  test('five',(){
    expect(InputItem.FIVE.label,'5');
    expect(InputItem.FIVE.display,'5');
    expect(InputItem.FIVE.value,'5');
  });

  test('six',(){
    expect(InputItem.SIX.label,'6');
    expect(InputItem.SIX.display,'6');
    expect(InputItem.SIX.value,'6');
  });

  test('seven',(){
    expect(InputItem.SEVEN.label,'7');
    expect(InputItem.SEVEN.display,'7');
    expect(InputItem.SEVEN.value,'7');
  });

  test('eight',(){
    expect(InputItem.EIGHT.label,'8');
    expect(InputItem.EIGHT.display,'8');
    expect(InputItem.EIGHT.value,'8');
  });

  test('nine',(){
    expect(InputItem.NINE.label,'9');
    expect(InputItem.NINE.display,'9');
    expect(InputItem.NINE.value,'9');
  });

  test('A',(){
    expect(InputItem.A.label,'A');
    expect(InputItem.A.display,'A');
    expect(InputItem.A.value,'A');
    expect(InputItem.A.variable,true);
  });

  test('B',(){
    expect(InputItem.B.label,'B');
    expect(InputItem.B.display,'B');
    expect(InputItem.B.value,'B');
    expect(InputItem.B.variable,true);
  });

  test('C',(){
    expect(InputItem.C.label,'C');
    expect(InputItem.C.display,'C');
    expect(InputItem.C.value,'C');
    expect(InputItem.C.variable,true);
  });

  test('D',(){
    expect(InputItem.D.label,'D');
    expect(InputItem.D.display,'D');
    expect(InputItem.D.value,'D');
    expect(InputItem.D.variable,true);
  });

  test('E',(){
    expect(InputItem.E.label,'E');
    expect(InputItem.E.display,'E');
    expect(InputItem.E.value,'E');
    expect(InputItem.E.variable,true);
  });

  test('F',(){
    expect(InputItem.F.label,'F');
    expect(InputItem.F.display,'F');
    expect(InputItem.F.value,'F');
    expect(InputItem.F.variable,true);
  });

  test('G',(){
    expect(InputItem.G.label,'G');
    expect(InputItem.G.display,'G');
    expect(InputItem.G.value,'G');
    expect(InputItem.G.variable,true);
  });

  test('H',(){
    expect(InputItem.H.label,'H');
    expect(InputItem.H.display,'H');
    expect(InputItem.H.value,'H');
    expect(InputItem.H.variable,true);
  });

  test('I',(){
    expect(InputItem.I.label,'I');
    expect(InputItem.I.display,'I');
    expect(InputItem.I.value,'I');
    expect(InputItem.I.variable,true);
  });

  test('J',(){
    expect(InputItem.J.label,'J');
    expect(InputItem.J.display,'J');
    expect(InputItem.J.value,'J');
    expect(InputItem.J.variable,true);
  });

  test('PI',(){
    expect(InputItem.PI.label,'𝜋');
    expect(InputItem.PI.display,'𝜋');
    expect(InputItem.PI.value,'𝜋');
  });

  test('CSC',(){
    expect(InputItem.CSC.label,'csc');
    expect(InputItem.CSC.display,'csc(');
    expect(InputItem.CSC.value,'csc(');
    expect(InputItem.CSC.function, true);
  });

  test('SEC',(){
    expect(InputItem.SEC.label,'sec');
    expect(InputItem.SEC.display,'sec(');
    expect(InputItem.SEC.value,'sec(');
    expect(InputItem.SEC.function, true);
  });

  test('COT',(){
    expect(InputItem.COT.label,'cot');
    expect(InputItem.COT.display,'cot(');
    expect(InputItem.COT.value,'cot(');
    expect(InputItem.COT.function, true);
  });

  test('E_POWER_X',(){
    expect(InputItem.E_POWER_X.label,'𝑒 ˣ');
    expect(InputItem.E_POWER_X.display,'𝑒^');
    expect(InputItem.E_POWER_X.value,'𝑒^');
  });

  test('SINH',(){
    expect(InputItem.SINH.label,'sinh');
    expect(InputItem.SINH.display,'sinh(');
    expect(InputItem.SINH.value,'sinh(');
    expect(InputItem.SINH.function, true);
  });

  test('COSH',(){
    expect(InputItem.COSH.label,'cosh');
    expect(InputItem.COSH.display,'cosh(');
    expect(InputItem.COSH.value,'cosh(');
    expect(InputItem.COSH.function, true);
  });

  test('TANH',(){
    expect(InputItem.TANH.label,'tanh');
    expect(InputItem.TANH.display,'tanh(');
    expect(InputItem.TANH.value,'tanh(');
    expect(InputItem.TANH.function, true);
  });

  test('INVERSE',(){
    expect(InputItem.INVERSE.label,'𝑥 ⁻¹');
    expect(InputItem.INVERSE.display,'⁻¹');
    expect(InputItem.INVERSE.value,'⁻¹');
  });

  test('ASIN',(){
    expect(InputItem.ASIN.label,'asin');
    expect(InputItem.ASIN.display,'asin(');
    expect(InputItem.ASIN.value,'asin(');
    expect(InputItem.ASIN.function, true);
  });

  test('ACOS',(){
    expect(InputItem.ACOS.label,'acos');
    expect(InputItem.ACOS.display,'acos(');
    expect(InputItem.ACOS.value,'acos(');
    expect(InputItem.ACOS.function, true);
  });

  test('ATAN',(){
    expect(InputItem.ATAN.label,'atan');
    expect(InputItem.ATAN.display,'atan(');
    expect(InputItem.ATAN.value,'atan(');
    expect(InputItem.ATAN.function, true);
  });

  test('FACTORIAL',(){
    expect(InputItem.COMMA.label,',');
    expect(InputItem.COMMA.display,',');
    expect(InputItem.COMMA.value,',');
  });

  test('ASINH',(){
    expect(InputItem.ASINH.label,'asinh');
    expect(InputItem.ASINH.display,'asinh(');
    expect(InputItem.ASINH.value,'asinh(');
    expect(InputItem.ASINH.function, true);
  });

  test('ACOSH',(){
    expect(InputItem.ACOSH.label,'acosh');
    expect(InputItem.ACOSH.display,'acosh(');
    expect(InputItem.ACOSH.value,'acosh(');
    expect(InputItem.ACOSH.function, true);
  });

  test('ATANH',(){
    expect(InputItem.ATANH.label,'atanh');
    expect(InputItem.ATANH.display,'atanh(');
    expect(InputItem.ATANH.value,'atanh(');
    expect(InputItem.ATANH.function, true);
  });

  test('storage',(){
    expect(InputItem.STORAGE.label,'sto');
    expect(InputItem.STORAGE.display,'➡');
    expect(InputItem.STORAGE.value,'➡');
    expect(InputItem.STORAGE.lookback,true);
  });

  test('EMPTY',(){
    expect(InputItem.EMPTY.label,'');
    expect(InputItem.EMPTY.display,'');
    expect(InputItem.EMPTY.value,'');
  });
}
