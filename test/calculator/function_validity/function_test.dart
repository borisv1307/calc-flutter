import 'package:open_calc/calculator/input_validation/validate_function.dart';
import 'package:test/test.dart';

ValidateFunction tester = new ValidateFunction();
void main(){
  group('input strings fail when not a valid math function:', () {

    group('invalid input', () {
      test('multiple decimals', () {
        var string = '3.45.6';
        expect(tester.testFunction(string), equals(false));
      });

      test('undefined function', () {
        var string = 'abc ( 3 + 4 )';
        expect(tester.testFunction(string), equals(false));
      });

      test('unexpected negative sign', () {
        var string = '-345-45-2';
        expect(tester.testFunction(string), equals(false));
      });

      test('lone decimal point', () {
        var string = '3 + .';
        expect(tester.testFunction(string), equals(false));
      });

      test('hanging decimal point', () {
        var string = '5 - 23.';
        expect(tester.testFunction(string), equals(false));
      });

      test('junk input', () {
        var string = '23xA4G5';
        expect(tester.testFunction(string), equals(false));
      });
    });
    
    group('no operands next to one another', () {
      test('no plus adjacent', () {
        var string = '2 + + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiplication adjacent', () {
        var string = '2 * * 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no division adjacent', () {
        var string = '2 / / 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no subtraction adjacent', () {
        var string = '2 - - 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no double exponentiation', () {
        var string = '2 ^ ^ 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj div', () {
        var string = '2 + / 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj plus', () {
        var string = '2 * + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj multiply', () {
        var string = '2 / * 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj plus', () {
        var string = '2 / + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj plus', () {
        var string = '2 - + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj div', () {
        var string = '2 ^ / 2';
        expect(tester.testFunction(string), equals(false));
      });
    });

    group('invalid pairs of parentheses', () {
      test('no unmatched open', () {
        var string = '2 * ( ( 2 )';
        expect(tester.testFunction(string), equals(false));
      });

      test('no unmatched close', () {
        var string = '2 / ( 2 ) )';
        expect(tester.testFunction(string), equals(false));
      });

      test('no empty parentheses', () {
        var string = '2 * ( )';
        expect(tester.testFunction(string), equals(false));
      });
      
      test('no unexpected close', () {
        var string = '2 * )';
        expect(tester.testFunction(string), equals(false));
      });

      test('no adjacent pairs', () {
        var string = '( 2 + 2 ) ( 2 + 2 )';
        expect(tester.testFunction(string), equals(false));
      });
    });
  });

  group('input strings pass when a valid math function:', () {
    group('valid numbers', () {
      test('positive int', () {
        var string = '123';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative int', () {
        var string = '-30';
        expect(tester.testFunction(string), equals(true));
      });

      test('positive decimal', () {
        var string = '45.31';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative decimal', () {
        var string = '-345.432';
        expect(tester.testFunction(string), equals(true));
      });

      test('decimal operation', () {
        var string = '45.3 * 234.665';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative addition', () {
        var string = '45 + -3';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative decimal division', () {
        var string = '-457.895 / -34.5';
        expect(tester.testFunction(string), equals(true));
      });
    });

    group('valid operators:', () {
      test('+', () {
        var string = '100 + 200';
        expect(tester.testFunction(string), equals(true));
      });

      test('-', () {
        var string = '35 - 6523';
        expect(tester.testFunction(string), equals(true));
      });

      test('/', () {
        var string = '-32 / 2';
        expect(tester.testFunction(string), equals(true));
      });
      
      test('*', () {
        var string = '4555 * -12';
        expect(tester.testFunction(string), equals(true));
      });

      test('^', () {
        var string = '3 ^ 4';
        expect(tester.testFunction(string), equals(true));
      });
    });

    group('valid functions:', () {
      test('log', () {
        var string = 'log ( 111 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('ln', () {
        var string = 'ln ( 45 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('sin', () {
        var string = 'sin ( 33.3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('cos', () {
        var string = 'cos ( -87 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('tan', () {
        var string = 'tan ( 12 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('abs', () {
        var string = 'abs ( -12345 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('csc', () {
        var string = 'csc ( 30 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('sec', () {
        var string = 'sec ( 5 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('cot', () {
        var string = 'cot ( -3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('sqrt', () {
        var string = 'sqrt ( 16 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('sinh', () {
        var string = 'sinh ( -1 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('cosh', () {
        var string = 'cosh ( 12 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('tanh', () {
        var string = 'tanh ( -2 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('asin', () {
        var string = 'asin ( 12 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acos', () {
        var string = 'acos ( 5 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('atan', () {
        var string = 'atan ( -30 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acsc', () {
        var string = 'acsc ( 30 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('asec', () {
        var string = 'asec ( 3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acot', () {
        var string = 'acot ( 2 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('csch', () {
        var string = 'csch ( 20 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('sech', () {
        var string = 'sech ( 1 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('coth', () {
        var string = 'coth ( -50 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('ceil', () {
        var string = 'ceil ( 7.004 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('asinh', () {
        var string = 'asinh ( 24 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acosh', () {
        var string = 'acosh ( 3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('atanh', () {
        var string = 'atanh ( -10 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acsch', () {
        var string = 'acsch ( 2 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('asech', () {
        var string = 'asech ( 4 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('acoth', () {
        var string = 'acoth ( 24 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('floor', () {
        var string = 'floor ( -5.05 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('round', () {
        var string = 'round ( 24.56 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('trunc', () {
        var string = 'trunc ( -32.9012 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('fract', () {
        var string = 'fract ( 0.5 )';
        expect(tester.testFunction(string), equals(true));
      });
    });

    group('parentheses expressions:', () {
      test('single operand inside parentheses', () {
        var string = '( -30 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('single parentheses', () {
        var string = '3 + ( 4 * 8 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi parentheses', () {
        var string = '5 * ( ( ( -3 ) / 4.5 ) + 666 )';
        expect(tester.testFunction(string), equals(true));
      });
      
      test('negative parentheses', () {
        var string = '4 + -( 30 * 2 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('basic negative parentheses', () {
        var string = '-( 3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative trig input', () {
        var string = '-sin ( 3 )';
        expect(tester.testFunction(string), equals(true));
      });

      test('negative logarithmic input', () {
        var string = '-ln ( 300 )';
        expect(tester.testFunction(string), equals(true));
      });
    });

    group('complex expressions:', () {
      test('valid parentheses', () {
        var string = '( 2 + 2 ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('sin and valid parentheses', () {
        var string = 'sin ( 2 + ( -4 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi trig and  parentheses', () {
        var string = 'sin ( 2 + cos ( -4 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi trig and  parentheses 2', () {
        var string = 'sin ( 2 + cos ( tan ( 2 ) - 1 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi trig and  parentheses 2', () {
        var string = 'sin ( 2 + cos ( tan ( 2 ) - 1 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('stacked functions', () {
        var string = '-log ( floor ( sinh ( cos ( atan ( log ( -round ( sin ( -10.3456 ) ) ) ) ) ^ sqrt ( 100.2 ) ) / cos ( -5 ) ) )';
        expect(tester.testFunction(string), equals(true));
      });
    });
  });
}
