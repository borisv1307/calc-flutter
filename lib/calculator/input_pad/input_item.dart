class InputItem{
  final String display;
  final String value;
  final bool catalog;

  const InputItem(this.display, {String value, this.catalog = true}):
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
  static const SUBTRACT = const InputItem('-');
  static const NATURAL_LOG = const InputItem('ln',value:'ln(');
  static const NEGATIVE = const InputItem('(-)',value:'-');
  static const DECIMAL = const InputItem('.',value:'.');
  static const ADD = const InputItem('+');
  static const ZERO = const InputItem('0', catalog:false);
  static const ONE = const InputItem('1',catalog:false);
  static const TWO = const InputItem('2',catalog:false);
  static const THREE = const InputItem('3',catalog:false);
  static const FOUR = const InputItem('4',catalog:false);
  static const FIVE = const InputItem('5',catalog:false);
  static const SIX = const InputItem('6',catalog:false);
  static const SEVEN = const InputItem('7',catalog:false);
  static const EIGHT = const InputItem('8',catalog:false);
  static const NINE = const InputItem('9',catalog:false);
  static const A = const InputItem('A',catalog:false);
  static const B = const InputItem('B',catalog:false);
  static const C = const InputItem('C',catalog:false);
  static const D = const InputItem('D',catalog:false);
  static const E = const InputItem('E',catalog:false);
  static const F = const InputItem('F',catalog:false);
  static const G = const InputItem('G',catalog:false);
  static const H = const InputItem('H',catalog:false);
  static const I = const InputItem('I',catalog:false);
  static const J = const InputItem('J',catalog:false);
}