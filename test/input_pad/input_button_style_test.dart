import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/input_pad/input_button_style.dart';

void main() {
  group('Primary button style', () {
    test('has black text',(){
      expect(InputButtonStyle.PRIMARY.textColor, Colors.black);
    });
    test('has white background',(){
      expect(InputButtonStyle.PRIMARY.backgroundColor, Colors.white);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.PRIMARY.fontSize, 32);
    });

    group('has elliptical shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.PRIMARY.radius.topRight.x,20);
        expect(InputButtonStyle.PRIMARY.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.PRIMARY.radius.topLeft.x,20);
        expect(InputButtonStyle.PRIMARY.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.PRIMARY.radius.bottomLeft.x,25);
        expect(InputButtonStyle.PRIMARY.radius.bottomLeft.y,15);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.PRIMARY.radius.bottomRight.x,25);
        expect(InputButtonStyle.PRIMARY.radius.bottomRight.y,15);
      });
    });
  });

  group('Secondary button style', () {
    test('has white text',(){
      expect(InputButtonStyle.SECONDARY.textColor, Colors.white);
    });
    test('has blue background',(){
      expect(InputButtonStyle.SECONDARY.backgroundColor, Colors.blue);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.SECONDARY.fontSize, 24);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.SECONDARY.radius.topRight.x,10);
        expect(InputButtonStyle.SECONDARY.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.SECONDARY.radius.topLeft.x,10);
        expect(InputButtonStyle.SECONDARY.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.SECONDARY.radius.bottomLeft.x,10);
        expect(InputButtonStyle.SECONDARY.radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.SECONDARY.radius.bottomRight.x,10);
        expect(InputButtonStyle.SECONDARY.radius.bottomRight.y,10);
      });
    });
  });

  group('Tertiary button style', () {
    test('has white text',(){
      expect(InputButtonStyle.TERTIARY.textColor, Colors.white);
    });
    test('has black background',(){
      expect(InputButtonStyle.TERTIARY.backgroundColor, Colors.black);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.TERTIARY.fontSize, 20);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.TERTIARY.radius.topRight.x,10);
        expect(InputButtonStyle.TERTIARY.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.TERTIARY.radius.topLeft.x,10);
        expect(InputButtonStyle.TERTIARY.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.TERTIARY.radius.bottomLeft.x,10);
        expect(InputButtonStyle.TERTIARY.radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.TERTIARY.radius.bottomRight.x,10);
        expect(InputButtonStyle.TERTIARY.radius.bottomRight.y,10);
      });
    });
  });
}