import 'package:test/test.dart';
import '../../lib/input_validation/validate_function.dart';

validateFunction tester = new validateFunction();
void main(){
  group('input strings fail when not a valid math function', () {
    
    group('no operands next to one another', () {

      test('no plus adjacent', () {
        var string = '2++2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiplication adjacent', () {
        var string = '2**2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no division adjacent', () {
        var string = '2//2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no subtraction adjacent', () {
        var string = '2--2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no double exponentiation', () {
        var string = '2^^2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj multiply', () {
        var string = '2+*2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj sub', () {
        var string = '2+-2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj div', () {
        var string = '2+/2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no plus adj exp', () {
        var string = '2+^2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj sub', () {
        var string = '2*-2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj div', () {
        var string = '2*/2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj plus', () {
        var string = '2*+2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no multiply adj exp', () {
        var string = '2*^2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj multiply', () {
        var string = '2/*2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj plus', () {
        var string = '2/+2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj sub', () {
        var string = '2/-2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no div adj exp', () {
        var string = '2/^2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj multiply', () {
        var string = '2-*2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj div', () {
        var string = '2-/2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj plus', () {
        var string = '2-+2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no sub adj exp', () {
        var string = '2-^2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj plus', () {
        var string = '2^+2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj sub', () {
        var string = '2^-2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj multiply', () {
        var string = '2^*2';
        expect(tester.testFunction(string), equals(false));
      });

      test('no exp adj div', () {
        var string = '2^/2';
        expect(tester.testFunction(string), equals(false));
      });
    });

    group('valid pairs of parentheses', () {

      test('no unmatched open', () {
        var string = '2*((2)';
        expect(tester.testFunction(string), equals(false));
      });

      test('no unmatched close', () {
        var string = '2/(2))';
        expect(tester.testFunction(string), equals(false));
      });

      test('no empty parentheses', () {
        var string = '2*()';
        expect(tester.testFunction(string), equals(false));
      });
    });
  });
}