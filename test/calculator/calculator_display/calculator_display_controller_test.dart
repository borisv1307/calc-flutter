import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

class TestableCalculatorDisplayController extends CalculatorDisplayController{
  bool notified = false;

  @override
  void notifyListeners(){
    notified= true;
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
      expect(controller.notified, true);
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
      expect(controller.notified, true);
    });
  });

}