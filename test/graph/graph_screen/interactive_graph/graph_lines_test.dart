import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_lines.dart';
import 'package:test/test.dart';

main(){
  group('Provided list',(){
    test('List is used',(){
      GraphLines graphLines = GraphLines([GraphLine('y')]);
      expect(graphLines.length,1);
      expect(graphLines[0].equation,'y');
    });

    test('Items are observed',(){
      GraphLines graphLines = GraphLines([GraphLine('y')]);
      bool notified = false;
      graphLines.addListener(() {
        notified = true;
      });
      graphLines[0].equation = 'z';
      expect(notified,isTrue);
    });
  });

  group('Item addition',(){
    GraphLines lines;
    bool notified = false;

    setUpAll((){
      lines = GraphLines();
      lines.addListener(() {
        notified = true;
      });
      lines.add(GraphLine('x'));
    });

    test('item is present',(){
      expect(lines[0].equation,'x');
    });

    test('subscriber is notified',(){
      expect(notified,true);
    });

    test('length is accurate',(){
      expect(lines.length,1);
    });
  });

  group('Item update',(){
    GraphLines lines;
    int notified = 0;

    setUpAll((){
      lines = GraphLines();
      lines.add(GraphLine('x'));
      lines.addListener(() {
        notified++;
      });
      lines[0] = GraphLine('y');
    });

    test('item is updated',(){
      expect(lines[0].equation,'y');
    });

    test('subscriber is notified twice',(){
      expect(notified, 1);
    });

    test('length is accurate',(){
      expect(lines.length,1);
    });
  });

  group('Item removed',(){
    group('existing item',(){
      GraphLines lines;
      int notified = 0;

      setUpAll((){
        lines = GraphLines();
        GraphLine line = GraphLine('x');
        lines.add(line);
        lines.addListener(() {
          notified++;
        });
        lines.remove(line);
      });


      test('subscriber is notified',(){
        expect(notified, 1);
      });

      test('length is accurate',(){
        expect(lines.length,0);
      });
    });

    test('non existing item',(){
      GraphLines lines = GraphLines();
      lines.add(GraphLine('x'));
      expect(lines.remove(4), false);
      expect(lines.length, 1);
    });
  });

  group('Item attribute update',(){
    group('Added item',(){
      GraphLines lines;
      int notified = 0;

      setUpAll((){
        lines = GraphLines();
        lines.add(GraphLine('x'));
        lines.addListener(() {
          notified++;
        });
        lines[0].equation = 'y';
      });

      test('subscriber is notified',(){
        expect(notified, 1);
      });
    });

    group('Updated item',(){
      GraphLines lines;
      int notified = 0;

      setUpAll((){
        lines = GraphLines();
        lines.add(GraphLine('x'));
        lines[0] = GraphLine('z');
        lines.addListener(() {
          notified++;
        });
        lines[0].equation = 'y';
      });

      test('item is updated',(){
        expect(lines[0].equation,'y');
      });

      test('subscriber is notified',(){
        expect(notified, 1);
      });
    });


    group('Old updated item',(){
      GraphLines lines;
      int notified = 0;

      setUpAll((){
        lines = GraphLines();
        GraphLine graphLine = GraphLine('x');
        lines.add(graphLine);
        lines[0] = GraphLine('y');
        lines.addListener(() {
          notified++;
        });
        graphLine.equation = 'z';
      });

      test('subscriber is not notified',(){
        expect(notified, 0);
      });
    });

    group('Old removed item',(){
      GraphLines lines;
      int notified = 0;

      setUpAll((){
        lines = GraphLines();
        GraphLine graphLine = GraphLine('x');
        lines.add(graphLine);
        lines.remove(graphLine);
        lines.addListener(() {
          notified++;
        });
        graphLine.equation = 'z';
      });

      test('subscriber is not notified',(){
        expect(notified, 0);
      });
    });
  });




}