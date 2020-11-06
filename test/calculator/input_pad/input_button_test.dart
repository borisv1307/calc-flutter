import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

void main() {
  testWidgets('Input button displays given text',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
    expect(find.text('2'),findsNWidgets(1));
  });

  group('Input button executes function when clicked',(){
    testWidgets('with provided text',(WidgetTester tester) async{
      String actualDisplay, actualValue = '';

      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){
        actualValue = text;
        actualDisplay = display;
      })));
      await tester.tap(find.byType(InputButton));
      expect(actualDisplay,'2');
      expect(actualValue,'2');
    });

    testWidgets('with provided value, display value',(WidgetTester tester) async{
      String actualDisplay, actualValue = '';

      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){
        actualValue = text;
        actualDisplay = display;
      }, display:'3', value:'4')));
      await tester.tap(find.byType(InputButton));
      expect(actualDisplay,'3');
      expect(actualValue,'4');
    });
  });

  group('Input button style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontSize,InputButtonStyle.PRIMARY.fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontWeight,InputButtonStyle.PRIMARY.fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.color,InputButtonStyle.PRIMARY.textColor);
    });

    testWidgets('style radius',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
      InkWell actualInkWell = tester.firstWidget(find.byType(InkWell));
      Material actualMaterial = tester.firstWidget(find.byType(Material));
      expect(actualInkWell.borderRadius,InputButtonStyle.PRIMARY.radius);
      expect(actualMaterial.borderRadius,InputButtonStyle.PRIMARY.radius);
    });
  });

  group('Button appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text, display){})));
      await expectLater(find.byType(MaterialApp),matchesGoldenFile('button-standard.png'));
    });
  });


}