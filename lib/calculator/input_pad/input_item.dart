class InputItem{
  final String display;
  final String value;
  final bool lookback;
  final bool variable;
  final bool replaceable;
  final bool function;

  const InputItem(this.display, {String value, this.lookback = false, this.variable = false, 
                                            bool replaceable = false, this.function = false}):
    this.value = value ?? display,
    this.replaceable = replaceable || variable;

  static const ANSWER = const InputItem('Ans', replaceable: true);
  static const SIN = const InputItem('sin',value:'sin(', function: true);
  static const COS = const InputItem('cos',value:'cos(', function: true);
  static const TAN = const InputItem('tan',value:'tan(', function: true);
  static const SQUARED = const InputItem('𝑥 ²',value:'²', lookback: true);
  static const OPEN_PARENTHESIS = const InputItem('(');
  static const CLOSE_PARENTHESIS = const InputItem(')', lookback: true);
  static const DIVIDE = const InputItem('÷',value:'/', lookback: true);
  static const MULTIPLY = const InputItem('x',value:'*', lookback: true);
  static const POWER = const InputItem('^', lookback: true);
  static const LOG = const InputItem('log',value:'log(', function: true);
  static const SUBTRACT = const InputItem('−', lookback: true);
  static const NATURAL_LOG = const InputItem('ln',value:'ln(', function: true);
  static const NEGATIVE = const InputItem('(-)',value:'-');
  static const DECIMAL = const InputItem('.',value:'.');
  static const ADD = const InputItem('+', lookback: true);
  static const ZERO = const InputItem('0');
  static const ONE = const InputItem('1');
  static const TWO = const InputItem('2');
  static const THREE = const InputItem('3');
  static const FOUR = const InputItem('4');
  static const FIVE = const InputItem('5');
  static const SIX = const InputItem('6');
  static const SEVEN = const InputItem('7');
  static const EIGHT = const InputItem('8');
  static const NINE = const InputItem('9');
  static const A = const InputItem('A', variable: true);
  static const B = const InputItem('B', variable: true);
  static const C = const InputItem('C', variable: true);
  static const D = const InputItem('D', variable: true);
  static const E = const InputItem('E', variable: true);
  static const F = const InputItem('F', variable: true);
  static const G = const InputItem('G', variable: true);
  static const H = const InputItem('H', variable: true);
  static const I = const InputItem('I', variable: true);
  static const J = const InputItem('J', variable: true);
  static const PI = const InputItem('𝜋');
  static const CSC = const InputItem('csc',value:'csc(', function: true);
  static const SEC = const InputItem('sec',value:'sec(', function: true);
  static const COT = const InputItem('cot',value:'cot(', function: true);
  static const E_POWER_X = const InputItem('𝑒 ˣ',value:'𝑒^');
  static const SINH = const InputItem('sinh',value:'sinh(', function: true);
  static const COSH = const InputItem('cosh',value:'cosh(', function: true);
  static const TANH = const InputItem('tanh',value:'tanh(', function: true);
  static const INVERSE = const InputItem('𝑥 ⁻¹',value:'⁻¹', lookback: true);
  static const ASIN = const InputItem('asin',value:'asin(', function: true);
  static const ACOS= const InputItem('acos',value:'acos(', function: true);
  static const ATAN = const InputItem('atan',value:'atan(', function: true);
  static const COMMA = const InputItem(',');
  static const ASINH = const InputItem('asinh',value:'asinh(', function: true);
  static const ACOSH = const InputItem('acosh',value:'acosh(', function: true);
  static const ATANH = const InputItem('atanh',value:'atanh(', function: true);
  static const SQUARE_ROOT = const InputItem('sqrt',value:'√(', function: true);
  static const STORAGE = const InputItem('sto', value:'➡', lookback: true);
  static const EMPTY = const InputItem('');

}