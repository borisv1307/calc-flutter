import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';


class MockContext extends Mock implements BuildContext{}

void main(){
  MockContext context = MockContext();  
  ThemeData defaultTheme = ThemeData.light();

  group('Primary pad_button style', () {
    test('has black text',(){
      expect(InputButtonStyle.primary(context).textColor, Colors.black);
    });
    test('background color reflects correct theme attribute',(){
      expect(InputButtonStyle.primary(context).backgroundColor, defaultTheme.colorScheme.primary);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.primary(context).fontSize, 32);
    });

    group('has elliptical shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.primary(context).radius.topRight.x,20);
        expect(InputButtonStyle.primary(context).radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.primary(context).radius.topLeft.x,20);
        expect(InputButtonStyle.primary(context).radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.primary(context).radius.bottomLeft.x,25);
        expect(InputButtonStyle.primary(context).radius.bottomLeft.y,15);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.primary(context).radius.bottomRight.x,25);
        expect(InputButtonStyle.primary(context).radius.bottomRight.y,15);
      });
    });
  });

  group('Secondary pad_button style', () {
    test('has white text',(){
      expect(InputButtonStyle.secondary(context).textColor, Colors.white);
    });
    test('background color reflects correct theme attribute',(){
      expect(InputButtonStyle.secondary(context).backgroundColor, defaultTheme.colorScheme.secondary);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.secondary(context).fontSize, 24);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.secondary(context).radius.topRight.x,10);
        expect(InputButtonStyle.secondary(context).radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.secondary(context).radius.topLeft.x,10);
        expect(InputButtonStyle.secondary(context).radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.secondary(context).radius.bottomLeft.x,10);
        expect(InputButtonStyle.secondary(context).radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.secondary(context).radius.bottomRight.x,10);
        expect(InputButtonStyle.secondary(context).radius.bottomRight.y,10);
      });
    });
  });

  group('Tertiary pad_button style', () {
    test('has white text',(){
      expect(InputButtonStyle.tertiary(context).textColor, Colors.white);
    });
    test('background color reflects correct theme attribute',(){
      expect(InputButtonStyle.tertiary(context).backgroundColor, defaultTheme.colorScheme.primaryVariant);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.tertiary(context).fontSize, 20);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.tertiary(context).radius.topRight.x,10);
        expect(InputButtonStyle.tertiary(context).radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.tertiary(context).radius.topLeft.x,10);
        expect(InputButtonStyle.tertiary(context).radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.tertiary(context).radius.bottomLeft.x,10);
        expect(InputButtonStyle.tertiary(context).radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.tertiary(context).radius.bottomRight.x,10);
        expect(InputButtonStyle.tertiary(context).radius.bottomRight.y,10);
      });
    });
  });

  group('Quartenary pad_button style', () {
    test('has black text',(){
      expect(InputButtonStyle.quartenary(context).textColor, Colors.black);
    });
    test('background color reflects correct theme attribute',(){
      expect(InputButtonStyle.quartenary(context).backgroundColor, defaultTheme.colorScheme.primary);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.quartenary(context).fontSize, 24);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.quartenary(context).radius.topRight.x,10);
        expect(InputButtonStyle.quartenary(context).radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.quartenary(context).radius.topLeft.x,10);
        expect(InputButtonStyle.quartenary(context).radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.quartenary(context).radius.bottomLeft.x,10);
        expect(InputButtonStyle.quartenary(context).radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.quartenary(context).radius.bottomRight.x,10);
        expect(InputButtonStyle.quartenary(context).radius.bottomRight.y,10);
      });
    });
  });
}