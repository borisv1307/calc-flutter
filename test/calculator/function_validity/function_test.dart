import 'package:open_calc/calculator/input_validation/validate_function.dart';
import 'package:test/test.dart';

ValidateFunction tester = new ValidateFunction();
void main(){
  group('input strings fail when not a valid math function', () {
    
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

      test('no plus adj multiply', () {
        var string = '2 + * 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj sub', () {
        var string = '2 + - 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj div', () {
        var string = '2 + / 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj exp', () {
        var string = '2 + ^ 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj sub', () {
        var string = '2 * - 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj div', () {
        var string = '2 * / 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj plus', () {
        var string = '2 * + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj exp', () {
        var string = '2 * ^ 2';
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

      test('no div adj sub', () {
        var string = '2 / - 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj exp', () {
        var string = '2 / ^ 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj multiply', () {
        var string = '2 - * 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj div', () {
        var string = '2 - / 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj plus', () {
        var string = '2 - + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj exp', () {
        var string = '2 - ^ 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj plus', () {
        var string = '2 ^ + 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj sub', () {
        var string = '2 ^ - 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj multiply', () {
        var string = '2 ^ * 2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj div', () {
        var string = '2 ^ / 2';
        expect(tester.testFunction(string), equals(false));
      });
    });

    group('invalid pairs of parentheses', () {

      test('no unmatched open', () {
        tester.counter = 0;
        var string = '2 * ( ( 2 )';
        expect(tester.testFunction(string), equals(false));
      });

      test('no unmatched close', () {
        tester.counter = 0;
        var string = '2 / ( 2 ) )';
        expect(tester.testFunction(string), equals(false));
      });

      test('no empty parentheses', () {
        tester.counter = 0;
        var string = '2 * ( )';
        expect(tester.testFunction(string), equals(false));
      });
    });
  });

  group('input strings pass when a valid math function', () {

    group('pass on valid operators', () {
      test('+', () {
        var string = '2 + 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('-', () {
        var string = '2 - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('/', () {
        var string = '2 / 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('*', () {
        var string = '2 * 2';
        expect(tester.testFunction(string), equals(true));
      });
    });

    group('pass on complex expressions', () {
      test('valid parentheses', () {
        tester.counter = 0;
        var string = '( 2 + 2 ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('sin and valid parentheses', () {
        tester.counter = 0;
        var string = 'sin ( 2 + ( -4 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi trig and  parentheses', () {
        tester.counter = 0;
        var string = 'sin ( 2 + cos ( -4 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });

      test('multi trig and  parentheses 2', () {
        tester.counter = 0;
        var string = 'sin ( 2 + cos ( tan ( 2 ) - 1 ) ) - 2';
        expect(tester.testFunction(string), equals(true));
      });
    });

  });
}
