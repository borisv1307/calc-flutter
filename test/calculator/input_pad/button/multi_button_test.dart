import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';


class MockContext extends Mock implements BuildContext{}

void main(){
  MockContext context = MockContext();

  group('Valid inputs',(){
    test('display text provided for long lists',(){
      expect(() => MultiButton([InputItem.COS,InputItem.COS,InputItem.COS,InputItem.COS,InputItem.COS],(text){}, InputButtonStyle.primary(context)), throwsAssertionError);
    });
  });

  group('Displays text',(){
    testWidgets('displays given text',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.primary(context), display:'hello')));
      expect(find.text('hello'),findsNWidgets(1));
    });

    testWidgets('displays items text',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.primary(context))));
      expect(find.text(InputItem.COS.label),findsNWidgets(1));
      expect(find.text(InputItem.SIN.label),findsNWidgets(1));
      expect(find.text(InputItem.TAN.label),findsNWidgets(1));
      expect(find.text(InputItem.SEC.label),findsNWidgets(1));
    });
  });

  group('Style applied',(){
    testWidgets('style font size',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.primary(context), display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.fontSize,InputButtonStyle.primary(context).fontSize);
    });

    testWidgets('style font weight',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.primary(context), display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.fontWeight,InputButtonStyle.primary(context).fontWeight);
    });

    testWidgets('style text color',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([],(text){}, InputButtonStyle.primary(context), display:'hello')));
      Text actualText = tester.firstWidget(find.text('hello'));
      expect(actualText.style.color,InputButtonStyle.primary(context).textColor);
    });
  });



  testWidgets('Button shows options',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.primary(context), display: 'hello',)));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    expect(find.text(InputItem.COS.label),findsNWidgets(1));
    expect(find.text(InputItem.SIN.label),findsNWidgets(1));
    expect(find.text(InputItem.TAN.label),findsNWidgets(1));
    expect(find.text(InputItem.SEC.label),findsNWidgets(1));
  });

  testWidgets('Click option calls input function',(WidgetTester tester) async{
    InputItem actualItem;
    await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(InputItem item){
      actualItem = item;
    }, InputButtonStyle.primary(context), display: 'hello',)));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(Container, InputItem.COS.label).first);
    await tester.pumpAndSettle();
    expect(actualItem,InputItem.COS);
  });

  group('Layout',(){
    testWidgets('display label',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS],(text){}, InputButtonStyle.primary(context), display: 'hello',)));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_display.png'));  
    });

    testWidgets('one item',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS],(text){}, InputButtonStyle.primary(context))));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_one_item.png'));
    });

    testWidgets('two items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN],(text){}, InputButtonStyle.primary(context))));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_two_items.png'));
    });

    testWidgets('three items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN],(text){}, InputButtonStyle.primary(context))));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_three_items.png'));
    });

    testWidgets('four items',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:MultiButton([InputItem.COS, InputItem.SIN, InputItem.TAN, InputItem.SEC],(text){}, InputButtonStyle.primary(context))));
      await expectLater(find.byType(MultiButton),matchesGoldenFile('multi_button_four_items.png'));
    });
  });
}