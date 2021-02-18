import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_direction.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_movement_calculator.dart';

void main(){
  group('No cursor',(){
    test('Moves up',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(null, CursorDirection.UP,1);
      expect(updatedLocation,Coordinates(0,1));
    });

    test('Moves down',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(null, CursorDirection.DOWN,1);
      expect(updatedLocation,Coordinates(0,-1));
    });

    test('Moves left',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(null, CursorDirection.LEFT,1);
      expect(updatedLocation,Coordinates(-1,0));
    });

    test('Moves right',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(null, CursorDirection.RIGHT,1);
      expect(updatedLocation,Coordinates(1,0));
    });
  });

  group('Existing cursor',(){
    test('Moves up',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(Coordinates(2, 4), CursorDirection.UP,1);
      expect(updatedLocation,Coordinates(2,5));
    });

    test('Moves down',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(Coordinates(2, 4), CursorDirection.DOWN,1);
      expect(updatedLocation,Coordinates(2,3));
    });

    test('Moves left',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(Coordinates(2, 4), CursorDirection.LEFT,1);
      expect(updatedLocation,Coordinates(1,4));
    });

    test('Moves right',(){
      CursorMovementCalculator calculator = CursorMovementCalculator();
      Coordinates updatedLocation = calculator.calculateMove(Coordinates(2, 4), CursorDirection.RIGHT,1);
      expect(updatedLocation,Coordinates(3,4));
    });
  });


  test('Steps',(){
    CursorMovementCalculator calculator = CursorMovementCalculator();
    Coordinates updatedLocation = calculator.calculateMove(Coordinates(0, 0), CursorDirection.RIGHT,5);
    expect(updatedLocation,Coordinates(5,0));
  });
}