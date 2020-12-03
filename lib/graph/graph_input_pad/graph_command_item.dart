class CommandItem{
  final String display;

  const CommandItem._(this.display);

  static const ENTER = CommandItem._('enter');
  static const DELETE = CommandItem._('del');
  static const CLEAR = CommandItem._('clear');
}