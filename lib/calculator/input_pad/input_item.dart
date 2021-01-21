class InputItem{
  final String label; //to display on buttons
  final String display; //to display on screen
  final String value; //to pass to backend
  final bool lookback; //if character references prior character
  final bool variable; //if represents a variable
  final bool replaceable; //if is a variable or Ans
  final bool function; //is a function
  final String name; //written name used for catalog

  const InputItem(this.label, {String display, String value, this.lookback = false, this.variable = false,
                                            bool replaceable = false, this.function = false, String name}):
    this.display = display ?? label,
    this.value = value ?? display ?? label,
    this.replaceable = replaceable || variable,
    this.name = name ?? label;

  static const ANSWER = const InputItem('Ans', replaceable: true);
  static const SIN = const InputItem('sin',display:'sin(', function: true);
  static const COS = const InputItem('cos',display:'cos(', function: true);
  static const TAN = const InputItem('tan',display:'tan(', function: true);
  static const SQUARED = const InputItem('𝑥 ²',display:'²', name:'square',lookback: true);
  static const OPEN_PARENTHESIS = const InputItem('(');
  static const CLOSE_PARENTHESIS = const InputItem(')', lookback: true);
  static const DIVIDE = const InputItem('÷',display:'/', name:'divide', lookback: true);
  static const MULTIPLY = const InputItem('x',display:'*', name: 'multiply', lookback: true);
  static const POWER = const InputItem('^', name:'power', lookback: true);
  static const LOG = const InputItem('log',display:'log(', function: true);
  static const SUBTRACT = const InputItem('—', value:'-', name:'subtract', lookback: true, function: true);
  static const NATURAL_LOG = const InputItem('ln',display:'ln(', function: true);
  static const NEGATIVE = const InputItem('(-)',display:'-', value:'`');
  static const DECIMAL = const InputItem('.',display:'.');
  static const ADD = const InputItem('+', name:'add',lookback: true);
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
  static const CSC = const InputItem('csc',display:'csc(', function: true);
  static const SEC = const InputItem('sec',display:'sec(', function: true);
  static const COT = const InputItem('cot',display:'cot(', function: true);
  static const E_POWER_X = const InputItem('𝑒 ˣ',display:'𝑒^');
  static const SINH = const InputItem('sinh',display:'sinh(', function: true);
  static const COSH = const InputItem('cosh',display:'cosh(', function: true);
  static const TANH = const InputItem('tanh',display:'tanh(', function: true);
  static const INVERSE = const InputItem('𝑥 ⁻¹',display:'⁻¹', lookback: true);
  static const ASIN = const InputItem('asin',display:'asin(', function: true);
  static const ACOS= const InputItem('acos',display:'acos(', function: true);
  static const ATAN = const InputItem('atan',display:'atan(', function: true);
  static const COMMA = const InputItem(',');
  static const ASINH = const InputItem('asinh',display:'asinh(', function: true);
  static const ACOSH = const InputItem('acosh',display:'acosh(', function: true);
  static const ATANH = const InputItem('atanh',display:'atanh(', function: true);
  static const SQUARE_ROOT = const InputItem('sqrt',display:'√(', function: true);
  static const X = const InputItem('𝑥', display: 'x');
  static const STORAGE = const InputItem('sto', display:'➡', lookback: true);
  static const EMPTY = const InputItem('');

}