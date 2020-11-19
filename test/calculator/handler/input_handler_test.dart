import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:test/test.dart';

class MockController extends Mock implements CalculatorDisplayController{}

void main(){
  test('input is displayed',(){
    MockController controller = MockController();
    InputHandler handler = InputHandler(controller);
    handler.handle(InputItem.A);

    verify(controller.input(InputItem.A)).called(1);
  });

  group('Answer prepending',(){
    test('is carried out with applicable input items',(){
      MockController controller = MockController();
      when(controller.inputItems).thenReturn([]);

      when(controller.history).thenReturn([DisplayHistory([InputItem.THREE], '3')]);
      InputHandler handler = InputHandler(controller);
      handler.handle(InputItem.ADD);

      verifyInOrder([controller.input(InputItem.ANSWER),controller.input(InputItem.ADD)]);
    });

    test('is not carried out with applicable input items if no history',(){
      MockController controller = MockController();
      when(controller.inputItems).thenReturn([]);

      InputHandler handler = InputHandler(controller);
      when(controller.history).thenReturn([]);
      handler.handle(InputItem.ADD);

      verify(controller.input(InputItem.ADD)).called(1);
      verifyNever(controller.input(any));
    });

    test('is not carried out when other input specified',(){
      MockController controller = MockController();
      when(controller.inputItems).thenReturn([InputItem.THREE]);
      when(controller.history).thenReturn([DisplayHistory([InputItem.THREE], '3')]);
      InputHandler handler = InputHandler(controller);
      handler.handle(InputItem.THREE);
      handler.handle(InputItem.ADD);

      verifyInOrder([controller.input(InputItem.THREE),controller.input(InputItem.ADD)]);
      verifyNever(controller.input(any));
    });
  });
}