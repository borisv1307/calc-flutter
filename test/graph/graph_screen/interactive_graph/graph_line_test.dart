import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line_bounds.dart';

main(){
  group('Color',(){
    bool notified = false;
    GraphLine line;

    setUpAll((){
      line = GraphLine('x');
      line.addListener(() {
        notified = true;
      });
      line.color = Colors.green;
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(line.color, Colors.green);
    });
  });

  group('equation',(){
    bool notified = false;
    GraphLine line;

    setUpAll((){
      line = GraphLine('x');
      line.addListener(() {
        notified = true;
      });
      line.equation = 'y';
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(line.equation, 'y');
    });
  });

  group('bounds',(){
    group('reassigned',(){
      bool notified = false;
      GraphLine line;
      GraphLineBounds bounds = GraphLineBounds();

      setUpAll((){
        line = GraphLine('x');
        line.addListener(() {
          notified = true;
        });
        line.segmentBounds = bounds;
      });

      test('subscribers are notified',(){
        expect(notified, isTrue);
      });

      test('is updated',(){
        expect(line.segmentBounds, bounds);
      });
    });

    test('notifies of bounds changes',(){
      GraphLine line = GraphLine('x');
      bool notified = false;
      line.addListener(() {
        notified = true;
      });
      line.segmentBounds.xMin = 2;
      expect(notified,isTrue);
    });

    test('notifies of updated bounds changes',(){
      GraphLine line = GraphLine('x');
      line.segmentBounds = GraphLineBounds();
      bool notified = false;
      line.addListener(() {
        notified = true;
      });
      line.segmentBounds.xMin = 2;
      expect(notified,isTrue);
    });

    test('does not notify of old bounds changes',(){
      GraphLine line = GraphLine('x');
      GraphLineBounds bounds = GraphLineBounds();
      line.segmentBounds = bounds;
      line.segmentBounds = GraphLineBounds();
      bool notified = false;
      line.addListener(() {
        notified = true;
      });

      bounds.xMin = 2;
      expect(notified,isFalse);
    });
  });
}