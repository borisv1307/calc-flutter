import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

void main() {
  testWidgets('Input button displays given text',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){})));
    expect(find.text('2'),findsNWidgets(1));
  });

  testWidgets('Input button executes function when clicked',(WidgetTester tester) async{
    bool called = false;

    await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){
      called = true;
    })));
    await tester.tap(find.byType(PadButton));
    expect(called,true);
  });

  group('Input button style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontSize,InputButtonStyle.WHITE_ROUNDED.fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.fontWeight,InputButtonStyle.WHITE_ROUNDED.fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){})));
      Text actualText = tester.firstWidget(find.text('2'));
      expect(actualText.style.color,InputButtonStyle.WHITE_ROUNDED.textColor);
    });

    testWidgets('style radius',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,(){})));
      InkWell actualInkWell = tester.firstWidget(find.byType(InkWell));
      Material actualMaterial = tester.firstWidget(find.byType(Material));
      expect(actualInkWell.borderRadius,InputButtonStyle.WHITE_ROUNDED.radius);
      expect(actualMaterial.borderRadius,InputButtonStyle.WHITE_ROUNDED.radius);
    });
  });

  group('Button appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      Function function = (){};
      await tester.pumpWidget(MaterialApp(home:PadButton('2',InputButtonStyle.WHITE_ROUNDED,function)));
      await expectLater(find.byType(MaterialApp),matchesGoldenFile('button-standard.png'));
    });
  });


}