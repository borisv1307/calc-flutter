import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:test/test.dart';

void main() {
  test('enter', () {
    expect(CommandItem.ENTER.display, 'enter');
  });

  test('delete', () {
    expect(CommandItem.DELETE.display, 'del');
  });

  test('clear', () {
    expect(CommandItem.CLEAR.display, 'clear');
  });

  test('sto', () {
    expect(CommandItem.STORAGE.display, 'sto');
  });
}