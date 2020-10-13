import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';

void main() {
  group('Input validation', () {
    test('should mandate larger max x than min x', () {
      expect(() => Bounds(2, 1, -2, 2), throwsAssertionError);
    });

    test('should mandate larger max y than min y', () {
      expect(() => Bounds(0, 1, 2, 1), throwsAssertionError);
    });
  });
}