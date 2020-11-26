import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

void main(){
  group('Valid inputs',(){
    test('display text provided for long lists',(){
      expect(() => MultiButton([InputItem.COS,InputItem.COS,InputItem.COS,InputItem.COS,InputItem.COS],(text){}, InputButtonStyle.PRIMARY), throwsAssertionError);
    });
  });

  group('Displays text',(){
    testWidgets('displays given text',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.PRIMARY, display:'hello')));
      expect(find.text('hello'),findsNWidgets(1));
    });

    testWidgets('displays items text',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.PRIMARY)));
      expect(find.text(InputItem.COS.display),findsNWidgets(1));
      expect(find.text(InputItem.SIN.display),findsNWidgets(1));
      expect(find.text(InputItem.TAN.display),findsNWidgets(1));
      expect(find.text(InputItem.SEC.display),findsNWidgets(1));
    });
  });

  group('Style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.PRIMARY, display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.fontSize,InputButtonStyle.PRIMARY.fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.PRIMARY, display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.fontWeight,InputButtonStyle.PRIMARY.fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.PRIMARY, display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.color,InputButtonStyle.PRIMARY.textColor);
    });
  });



  testWidgets('Button shows options',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.PRIMARY, display: 'hello',)));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    expect(find.text(InputItem.COS.display),findsNWidgets(1));
    expect(find.text(InputItem.SIN.display),findsNWidgets(1));
    expect(find.text(InputItem.TAN.display),findsNWidgets(1));
    expect(find.text(InputItem.SEC.display),findsNWidgets(1));
  });

  testWidgets('Click option calls input function',(WidgetTester tester) async{
    InputItem actualItem;
    await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(InputItem item){
      actualItem = item;
    }, InputButtonStyle.PRIMARY, display: 'hello',)));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(Container, InputItem.COS.display).first);
    await tester.pumpAndSettle();
    expect(actualItem,InputItem.COS);
  });

  group('Layout',(){
    testWidgets('display label',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS],(text){}, InputButtonStyle.PRIMARY, display: 'hello',)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_display.png'));
    });

    testWidgets('one item',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS],(text){}, InputButtonStyle.PRIMARY)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_one_item.png'));
    });

    testWidgets('two items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN],(text){}, InputButtonStyle.PRIMARY)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_two_items.png'));
    });

    testWidgets('three items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN],(text){}, InputButtonStyle.PRIMARY)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_three_items.png'));
    });

    testWidgets('four items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.PRIMARY)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_four_items.png'));
    });
  });
}