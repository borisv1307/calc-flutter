import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

void main() {
  group('Primary pad_button style', () {
    test('has black text',(){
      expect(InputButtonStyle.WHITE_ROUNDED.textColor, Colors.black);
    });
    test('has white background',(){
      expect(InputButtonStyle.WHITE_ROUNDED.backgroundColor, Colors.white);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.WHITE_ROUNDED.fontSize, 32);
    });

    group('has elliptical shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.WHITE_ROUNDED.radius.topRight.x,20);
        expect(InputButtonStyle.WHITE_ROUNDED.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.WHITE_ROUNDED.radius.topLeft.x,20);
        expect(InputButtonStyle.WHITE_ROUNDED.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.WHITE_ROUNDED.radius.bottomLeft.x,25);
        expect(InputButtonStyle.WHITE_ROUNDED.radius.bottomLeft.y,15);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.WHITE_ROUNDED.radius.bottomRight.x,25);
        expect(InputButtonStyle.WHITE_ROUNDED.radius.bottomRight.y,15);
      });
    });
  });

  group('Secondary pad_button style', () {
    test('has white text',(){
      expect(InputButtonStyle.BLUE_LARGE_TEXT.textColor, Colors.white);
    });
    test('has blue background',(){
      expect(InputButtonStyle.BLUE_LARGE_TEXT.backgroundColor, Colors.blue);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.BLUE_LARGE_TEXT.fontSize, 24);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.topRight.x,10);
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.topLeft.x,10);
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.bottomLeft.x,10);
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.bottomRight.x,10);
        expect(InputButtonStyle.BLUE_LARGE_TEXT.radius.bottomRight.y,10);
      });
    });
  });

  group('Tertiary pad_button style', () {
    test('has white text',(){
      expect(InputButtonStyle.BLACK_SMALL_TEXT.textColor, Colors.white);
    });
    test('has black background',(){
      expect(InputButtonStyle.BLACK_SMALL_TEXT.backgroundColor, Colors.black);
    });

    test('has correct font size',(){
      expect(InputButtonStyle.BLACK_SMALL_TEXT.fontSize, 20);
    });

    group('has round shape',(){
      test('has rounded top right',(){
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.topRight.x,10);
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.topRight.y,10);
      });

      test('has rounded top left',(){
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.topLeft.x,10);
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.topLeft.y,10);
      });

      test('has rounded bottom left',(){
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.bottomLeft.x,10);
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.bottomLeft.y,10);
      });

      test('has rounded bottom right',(){
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.bottomRight.x,10);
        expect(InputButtonStyle.BLACK_SMALL_TEXT.radius.bottomRight.y,10);
      });
    });
  });
}