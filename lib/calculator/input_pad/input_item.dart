class InputItem{
  final String display;
  final String value;

  const InputItem(this.display, {String value}):
    this.value = value ?? display;

  static const SIN = const InputItem('sin',value:'sin(');
  static const COS = const InputItem('cos',value:'cos(');
  static const TAN = const InputItem('tan',value:'tan(');
  static const SQUARED = const InputItem('𝑥 ²',value:'²');
  static const OPEN_PARENTHESIS = const InputItem('(');
  static const CLOSE_PARENTHESIS = const InputItem(')');
  static const DIVIDE = const InputItem('÷',value:'/');
  static const MULTIPLY = const InputItem('x',value:'*');
  static const POWER = const InputItem('^');
  static const LOG = const InputItem('log',value:'log(');
  static const SUBTRACT = const InputItem('−');
  static const NATURAL_LOG = const InputItem('ln',value:'ln(');
  static const NEGATIVE = const InputItem('(-)',value:'-');
  static const DECIMAL = const InputItem('.',value:'.');
  static const ADD = const InputItem('+');
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
  static const A = const InputItem('A');
  static const B = const InputItem('B');
  static const C = const InputItem('C');
  static const D = const InputItem('D');
  static const E = const InputItem('E');
  static const F = const InputItem('F');
  static const G = const InputItem('G');
  static const H = const InputItem('H');
  static const I = const InputItem('I');
  static const J = const InputItem('J');
}