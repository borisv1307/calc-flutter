import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
// import 'package:test/test.dart';


class MockContext extends Mock implements BuildContext{}


void main(){
  MockContext context = MockContext();

  testWidgets('Input button executes function when clicked',(WidgetTester tester) async{
    InputItem actualValue;

    await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.primary(context),(inputItem){
      actualValue = inputItem;
    })));
    await tester.tap(find.byType(InputButton));
    expect(actualValue,InputItem.TWO);
  });

  testWidgets('Input button displays given text',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.SIN,InputButtonStyle.primary(context),(text){})));
    expect(find.text('sin'),findsNWidgets(1));
  });

  group('Input button style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.primary(context),(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontSize,InputButtonStyle.primary(context).fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.primary(context),(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontWeight,InputButtonStyle.primary(context).fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.primary(context),(text){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.color,InputButtonStyle.primary(context).textColor);
    });

    testWidgets('style radius',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputButton(InputItem.TWO,InputButtonStyle.primary(context),(text){})));
      InkWell actualInkWell = tester.firstWidget(find.byType(InkWell));
      Material actualMaterial = tester.firstWidget(find.byType(Material));
      expect(actualInkWell.borderRadius,InputButtonStyle.primary(context).radius);
      expect(actualMaterial.borderRadius,InputButtonStyle.primary(context).radius);
    });
  });
}