import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line_bounds.dart';
import 'package:test/test.dart';

void main(){
  group('xMin',(){
    bool notified = false;
    GraphLineBounds bounds;

    setUpAll((){
      bounds = GraphLineBounds();
      bounds.addListener(() {
        notified = true;
      });
      bounds.xMin = 2;
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(bounds.xMin, 2);
    });
  });

  group('xMax',(){
    bool notified = false;
    GraphLineBounds bounds;

    setUpAll((){
      bounds = GraphLineBounds();
      bounds.addListener(() {
        notified = true;
      });
      bounds.xMax = 2;
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(bounds.xMax, 2);
    });
  });

  group('yMin',(){
    bool notified = false;
    GraphLineBounds bounds;

    setUpAll((){
      bounds = GraphLineBounds();
      bounds.addListener(() {
        notified = true;
      });
      bounds.yMin = 2;
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(bounds.yMin, 2);
    });
  });

  group('yMax',(){
    bool notified = false;
    GraphLineBounds bounds;

    setUpAll((){
      bounds = GraphLineBounds();
      bounds.addListener(() {
        notified = true;
      });
      bounds.yMax = 2;
    });

    test('subscribers are notified',(){
      expect(notified, isTrue);
    });

    test('is updated',(){
      expect(bounds.yMax, 2);
    });
  });
}