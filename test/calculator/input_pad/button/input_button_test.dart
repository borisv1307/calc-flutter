import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

void main(){
  testWidgets('Input button executes function when clicked',(WidgetTester tester) async{
    InputItem actualValue;

    await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.PRIMARY,(inputItem){
      actualValue = inputItem;
    })));
    await tester.tap(find.byType(InputButton));
    expect(actualValue,InputItem.TWO);
  });

  testWidgets('Input button displays given text',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.SIN,InputButtonStyle.PRIMARY,(text){})));
    expect(find.text('sin'),findsNWidgets(1));
  });

  group('Input button style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontSize,InputButtonStyle.PRIMARY.fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontWeight,InputButtonStyle.PRIMARY.fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.PRIMARY,(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.color,InputButtonStyle.PRIMARY.textColor);
    });

    testWidgets('style radius',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.PRIMARY,(text){})));
      InkWell actualInkWell = tester.firstWidget(find.byType(InkWell));
      Material actualMaterial = tester.firstWidget(find.byType(Material));
      expect(actualInkWell.borderRadius,InputButtonStyle.PRIMARY.radius);
      expect(actualMaterial.borderRadius,InputButtonStyle.PRIMARY.radius);
    });
  });
}