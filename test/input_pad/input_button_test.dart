import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/input_pad/input_button.dart';
import 'package:open_calc/input_pad/input_button_style.dart';

void main() {
  testWidgets('Input button displays given text',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
    expect(find.text('2'),findsNWidgets(1));
  });

  group('Input button executes function when clicked',(){
    testWidgets('with provided text',(WidgetTester tester) async{
      String actualText = '';

      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){
        actualText = text;
      })));
      await tester.tap(find.byType(InputButton));
      expect(actualText,'2');
    });

    testWidgets('with provided value',(WidgetTester tester) async{
      String actualText = '';

      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){
        actualText = text;
      }, '4')));
      await tester.tap(find.byType(InputButton));
      expect(actualText,'4');
    });
  });

  group('Input button style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontSize,InputButtonStyle.PRIMARY.fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontWeight,InputButtonStyle.PRIMARY.fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.color,InputButtonStyle.PRIMARY.textColor);
    });

    testWidgets('style radius',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
      InkWell actualInkWell = tester.firstWidget(find.byType(InkWell));
      Material actualMaterial = tester.firstWidget(find.byType(Material));
      expect(actualInkWell.borderRadius,InputButtonStyle.PRIMARY.radius);
      expect(actualMaterial.borderRadius,InputButtonStyle.PRIMARY.radius);
    });
  });

  group('Button appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton('2',InputButtonStyle.PRIMARY,(text){})));
      await expectLater(find.byType(MaterialApp),matchesGoldenFile('button-standard.png'));
    });
  });


}