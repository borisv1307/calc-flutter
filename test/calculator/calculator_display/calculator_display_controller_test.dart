import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

class TestableCalculatorDisplayController extends CalculatorDisplayController{
  int notified = 0;

  @override
  void notifyListeners(){
    notified++;
  }
}

void main(){

  group('History',(){
    test('is initially empty',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      expect(controller.history,isEmpty);
    });

    test('can be updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.history = [DisplayHistory('','')];
      expect(controller.history.length,1);
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.history = [DisplayHistory('','')];
      expect(controller.notified, 1);
    });
  });

  group('Input line',(){
    test('is initially blank',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      expect(controller.inputLine,'');
    });

    test('can be updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'hello';
      expect(controller.inputLine, 'hello');
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'hello';
      expect(controller.notified, 1);
    });
  });

  group('Cursor index',(){
    test('is initially at the starting position',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      expect(controller.cursorIndex, 0);
    });

    test('can be updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.cursorIndex = 5;
      expect(controller.cursorIndex, 5);
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.cursorIndex = 5;
      expect(controller.notified, 1);
    });

    test('is at end of new input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      expect(controller.cursorIndex,3);
    });

    test('is incremented to track input',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      controller.input('d');
      expect(controller.cursorIndex,4);
    });
  });

  group('Input',(){
    test('can be read from the input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.input('a');
      expect(controller.inputLine,'a');
    });

    test('is appended to end of input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.input('a');
      controller.input('b');
      expect(controller.inputLine,'ab');
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.input('a');
      expect(controller.notified, 1);
    });

    test('is inserted at cursor location',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      controller.cursorIndex = 1;
      controller.input('d');
      expect(controller.inputLine,'adbc');
    });
  });

  group('Deleting',(){
    test('character at cursor location can be deleted',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      controller.cursorIndex = 1;
      controller.delete();
      expect(controller.inputLine,'ac');
    });

    test('does not delete when cursor not on character',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      controller.delete();
      expect(controller.inputLine,'abc');
    });

    test('notifies listener',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController();
      controller.inputLine = 'abc';
      controller.cursorIndex = 1;
      controller.delete();
      expect(controller.notified, 3);
    });

  });
}