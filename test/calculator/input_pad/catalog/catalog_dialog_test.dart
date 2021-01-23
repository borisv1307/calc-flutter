import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/catalog/catalog_dialog.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  group('Shows items',(){
    void assertLocation(WidgetTester tester, InputItem item, int index) async{
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){})));
      List<Widget> allItems = tester.widgetList(find.byType(ItemTags)).toList();
      expect((allItems[index] as ItemTags).title, item.label);
    }

    testWidgets('add',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ADD, 0);
    });

    testWidgets('subtract',(WidgetTester tester) async{
      assertLocation(tester, InputItem.SUBTRACT, 1);
    });

    testWidgets('multiply',(WidgetTester tester) async{
      assertLocation(tester, InputItem.MULTIPLY, 2);
    });

    testWidgets('divide',(WidgetTester tester) async{
      assertLocation(tester, InputItem.DIVIDE, 3);
    });

    testWidgets('decimal',(WidgetTester tester) async{
      assertLocation(tester, InputItem.DECIMAL, 4);
    });

    testWidgets('comma',(WidgetTester tester) async{
      assertLocation(tester, InputItem.COMMA, 5);
    });

    testWidgets('power',(WidgetTester tester) async{
      assertLocation(tester, InputItem.POWER, 6);
    });

    testWidgets('open parenthesis',(WidgetTester tester) async{
      assertLocation(tester, InputItem.OPEN_PARENTHESIS, 7);
    });

    testWidgets('close parenthesis',(WidgetTester tester) async{
      assertLocation(tester, InputItem.CLOSE_PARENTHESIS, 8);
    });

    testWidgets('negative',(WidgetTester tester) async{
      assertLocation(tester, InputItem.NEGATIVE, 9);
    });

    testWidgets('acos',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ACOS, 10);
    });

    testWidgets('acosh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ACOSH, 11);
    });

    testWidgets('ans',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ANSWER, 12);
    });

    testWidgets('asin',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ASIN, 13);
    });

    testWidgets('asinh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ASINH, 14);
    });

    testWidgets('atan',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ATAN, 15);
    });

    testWidgets('atanh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.ATANH, 16);
    });

    testWidgets('cos',(WidgetTester tester) async{
      assertLocation(tester, InputItem.COS, 17);
    });

    testWidgets('cosh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.COSH, 18);
    });

    testWidgets('cot',(WidgetTester tester) async{
      assertLocation(tester, InputItem.COT, 19);
    });

    testWidgets('csc',(WidgetTester tester) async{
      assertLocation(tester, InputItem.CSC, 20);
    });

    testWidgets('e^x',(WidgetTester tester) async{
      assertLocation(tester, InputItem.E_POWER_X, 21);
    });

    testWidgets('ln',(WidgetTester tester) async{
      assertLocation(tester, InputItem.NATURAL_LOG, 22);
    });

    testWidgets('log',(WidgetTester tester) async{
      assertLocation(tester, InputItem.LOG, 23);
    });

    testWidgets('sec',(WidgetTester tester) async{
      assertLocation(tester, InputItem.SEC, 24);
    });

    testWidgets('sin',(WidgetTester tester) async{
      assertLocation(tester, InputItem.SIN, 25);
    });

    testWidgets('sinh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.SINH, 26);
    });

    testWidgets('tan',(WidgetTester tester) async{
      assertLocation(tester, InputItem.TAN, 27);
    });

    testWidgets('tanh',(WidgetTester tester) async{
      assertLocation(tester, InputItem.TANH, 28);
    });

    testWidgets('x^-1',(WidgetTester tester) async{
      assertLocation(tester, InputItem.INVERSE, 29);
    });

    testWidgets('squared',(WidgetTester tester) async{
      assertLocation(tester, InputItem.SQUARED, 30);
    });
  });

  group('clicking item',(){
    testWidgets('triggers provided on tap function', (WidgetTester tester) async{
      InputItem actualItem;
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){
        actualItem = item;
      })));

      InputItem expectedItem = InputItem.COS;
      await tester.tap(find.byWidgetPredicate((widget) => widget is ItemTags && widget.title == expectedItem.label));

      expect(actualItem, expectedItem);
    });

    testWidgets('closes popup', (WidgetTester tester) async{
      MockNavigatorObserver observer = MockNavigatorObserver();
      
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){}),navigatorObservers: [observer],));
      
      await tester.tap(find.byWidgetPredicate((widget) => widget is ItemTags && widget.title == InputItem.COS.label));

      verify(observer.didPop(any, any));
    });
  });

  group('searches',(){
    testWidgets('based on display', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){})));
      await tester.enterText(find.byType(TextField), 'CSC');
      await tester.pumpAndSettle();
      expect(find.byType(ItemTags),findsOneWidget);
      expect((find.byType(ItemTags).evaluate().single.widget as ItemTags).title, 'csc');
    });

    testWidgets('based on value', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){})));
      await tester.enterText(find.byType(TextField), 'CSC(');
      await tester.pumpAndSettle();
      expect(find.byType(ItemTags),findsOneWidget);
      expect((find.byType(ItemTags).evaluate().single.widget as ItemTags).title, 'csc');
    });

    testWidgets('based on name', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){})));
      await tester.enterText(find.byType(TextField), 'DIVIDE');
      await tester.pumpAndSettle();
      expect(find.byType(ItemTags),findsOneWidget);
      expect((find.byType(ItemTags).evaluate().single.widget as ItemTags).title, '÷');
    });

    testWidgets('no matches found', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CatalogDialog((InputItem item){})));
      await tester.enterText(find.byType(TextField), 'junk');
      await tester.pumpAndSettle();
      expect(find.byType(ItemTags),findsNothing);
      expect(find.text('No matches found'),findsOneWidget);
    });
  });
  
  
}