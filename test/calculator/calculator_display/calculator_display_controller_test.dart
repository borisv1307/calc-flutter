import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestableCalculatorDisplayController extends CalculatorDisplayController{
  int notified = 0;

  TestableCalculatorDisplayController(SettingsController settings) : super(settings);

  @override
  void notifyListeners(){
    notified++;
  }
}

void main(){
  SettingsController settingsController;

  setUp(() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    settingsController = SettingsController(pref);
    settingsController.reset();
  });

  group('History',(){
    test('is initially empty',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.history,isEmpty);
    });

    test('can be updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      expect(controller.history.length,1);
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      expect(controller.notified, 1);
    });

    test('is maintained after clear',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      controller.clearHistory();
      expect(controller.notified, 2);
      expect(controller.history.length, 1);
      expect(controller.itemsDisplayed, 0);
    });
  });

  group('Displayed History',(){
    test('is initially empty',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.displayedHistory,isEmpty);
    });

    test('matches history before clear',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      expect(controller.history,controller.displayedHistory);
    });

    test('is able to be cleared without clearing history',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      controller.clearHistory();
      expect(controller.displayedHistory.length, 0);
      expect(controller.history.length, 1);
    });

    test('add after clear',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([],''));
      controller.clearHistory();
      controller.add(DisplayHistory([],''));
      expect(controller.displayedHistory.length, 1);
      expect(controller.history.length, 2);
    });
  });

  group('Settings',(){
    test('load default values',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.displayedHistory,isEmpty);
    });

    test('history is able to be loaded from shared preferences',(){
      List<DisplayHistory> history = [
        DisplayHistory([InputItem.ONE,InputItem.ADD,InputItem.TWO], '3'),
        DisplayHistory([InputItem.FOUR,], '4'),
      ];
      settingsController.setCalcHistory(history);
      settingsController.setCalcItems(2);
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.history,history);
      expect(controller.itemsDisplayed,2);
      expect(controller.displayedHistory,history);
    });
  });

  group('Input line',(){
    test('is initially blank',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.inputLine,'');
    });
  });

  group('Input clearing',(){
    test('clears prior inputs',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.clearInput();
      expect(controller.inputLine,'');
    });

    test('notifies listeners',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.clearInput();
      expect(controller.notified,2);
    });

    test('resets cursor',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.clearInput();
      expect(controller.cursorIndex,0);
    });

    test('does not clear references to old input',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      List<InputItem> oldInput = controller.inputItems;
      controller.clearInput();
      expect(oldInput, contains(InputItem.A));
    });
  });

  group('Cursor index',(){
    test('is initially at the starting position',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.cursorIndex, 0);
    });

    test('can be updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.A);
      controller.cursorIndex = 1;
      expect(controller.cursorIndex, 1);
    });

    test('snaps to nearest item when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.COS);
      controller.cursorIndex = 2;
      expect(controller.cursorIndex, 0);
    });

    test('can be updated to be after all entered text',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.COS);
      controller.cursorIndex = 4;
      expect(controller.cursorIndex, 4);
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.cursorIndex = 5;
      expect(controller.notified, 1);
    });

    test('is at end of new input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      controller.input(InputItem.C);
      expect(controller.cursorIndex,3);
    });

    test('is incremented to track input',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      controller.input(InputItem.C);
      controller.input(InputItem.A);
      expect(controller.cursorIndex,4);
    });
  });

  group('Input',(){
    test('can be read from the input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      expect(controller.inputLine,'A');
    });

    test('displays display text',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.NEGATIVE);
      expect(controller.inputLine,'-');
    });

    test('is appended to end of input line',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      expect(controller.inputLine,'AB');
    });

    test('notifies listeners when updated',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      expect(controller.notified, 1);
    });

    test('is inserted at cursor location',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      controller.input(InputItem.C);
      controller.cursorIndex = 1;
      controller.input(InputItem.D);
      expect(controller.inputLine,'ADBC');
    });
  });

  group('Deleting',(){
    test('character at cursor location can be deleted',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      controller.input(InputItem.C);
      controller.cursorIndex = 1;
      controller.delete();
      expect(controller.inputLine,'AC');
    });

    test('does not delete when cursor not on character',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.input(InputItem.B);
      controller.input(InputItem.C);
      controller.delete();
      expect(controller.inputLine,'ABC');
    });

    test('notifies listener',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.input(InputItem.A);
      controller.cursorIndex = 0;
      controller.delete();
      expect(controller.notified, 3);
    });
  });

  group('Browsing history',(){

    test('displays cursor after text when browsing backwards',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([InputItem.ONE],'1'));
      controller.add(DisplayHistory([InputItem.TWO],'2'));
      controller.browseBackwards();
      expect(controller.cursorIndex, 1);
    });

    test('displays cursor after text when browsing forwards',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      controller.add(DisplayHistory([InputItem.ONE],'1'));
      controller.add(DisplayHistory([InputItem.TWO],'2'));
      controller.browseBackwards();
      controller.browseBackwards();
      controller.browseForwards();
      expect(controller.cursorIndex, 1);
    });

    group('when history present',(){
      TestableCalculatorDisplayController controller;
      setUp((){
        controller = TestableCalculatorDisplayController(settingsController);
        controller.add(DisplayHistory([InputItem.ONE],'1'));
        controller.add(DisplayHistory([InputItem.TWO],'2'));
      });

      test('can browse backwards',(){
        controller.browseBackwards();
        expect(controller.notified, 3);//two for initial history set
        expect(controller.inputLine,'2');
      });

      test('can browse further backwards',(){
        controller.browseBackwards();
        controller.browseBackwards();
        expect(controller.notified, 4);//two for initial history set
        expect(controller.inputLine,'1');
      });

      test('can edit input after browsing backwards without impacting history',(){
        controller.browseBackwards();
        expect(controller.inputItems,isNot(same(controller.history[1].input)));
      });

      test('can edit input after browsing forwards without impacting history',(){
        controller.browseBackwards();
        controller.browseBackwards();
        controller.browseForwards();
        expect(controller.inputItems,isNot(same(controller.history[1].input)));
      });

      test('can browse forwards after browsing backwards',(){
        controller.browseBackwards();
        controller.browseBackwards();
        controller.browseForwards();
        expect(controller.notified, 5);//two for initial history set
        expect(controller.inputLine,'2');
      });

      test('cannot browse before oldest entry',(){
        controller.browseBackwards();
        controller.browseBackwards();
        controller.browseBackwards();
        expect(controller.notified, 4);//two for initial history set
        expect(controller.inputLine,'1');
      });

      test('cannot browse forwards after viewing newest entry',(){
        controller.browseBackwards();
        controller.browseBackwards();
        controller.browseForwards();
        controller.browseForwards();
        expect(controller.notified, 5);//two for initial history set
        expect(controller.inputLine,'2');
      });
    });

    group('when no history present',(){
      TestableCalculatorDisplayController controller;
      setUp((){
        controller = TestableCalculatorDisplayController(settingsController);
      });

      test('cannot browse backwards',(){
        controller.browseBackwards();
        expect(controller.notified, 0);
        expect(controller.inputLine,'');
      });

      test('cannot browse forwards',(){
        controller.browseForwards();
        expect(controller.notified, 0);//one for initial history set
        expect(controller.inputLine,'');
      });
    });

    group('after updating input',(){
      TestableCalculatorDisplayController controller;
      setUp((){
        controller = TestableCalculatorDisplayController(settingsController);
        controller.add(DisplayHistory([InputItem.ONE],'1'));
        controller.add(DisplayHistory([InputItem.TWO],'2'));
      });

      test('can browse backwards',(){
        controller.browseBackwards();
        controller.add(DisplayHistory([InputItem.ONE],'1'));
        controller.add(DisplayHistory([InputItem.TWO],'2'));
        controller.add(DisplayHistory([InputItem.TWO],'2'));
        controller.clearInput();
        controller.browseBackwards();
        controller.browseBackwards();
        expect(controller.notified, 9);
        expect(controller.inputLine,'2');
      });
    });
  });
  group('Alerts',(){
    test('are initially not present',(){
      TestableCalculatorDisplayController controller = TestableCalculatorDisplayController(settingsController);
      expect(controller.popAlert(), isNull);
    });

    group('alert updates',(){
      TestableCalculatorDisplayController controller;
      setUpAll((){
        controller = TestableCalculatorDisplayController(settingsController);
        controller.pushAlert('demo');
      });

      test('updates subscribers',(){
        expect(controller.notified, 1);
      });

      test('can be popped',(){
        expect(controller.popAlert(), 'demo');
      });

      test('is non-existent after being popped',(){
        expect(controller.popAlert(), null);
      });
    });

  });
}