import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_direction.dart';

class CursorMovementCalculator{
  Coordinates calculateMove(Coordinates startCoordinates, CursorDirection direction, double step){
    double updatedX = startCoordinates?.x ?? 0;
    double updatedY = startCoordinates?.y ?? 0;

    if (direction == CursorDirection.UP) {
      updatedY += step;
    } else if (direction == CursorDirection.DOWN) {
      updatedY -= step;
    } else if (direction == CursorDirection.RIGHT) {
      updatedX += step;
    } else if (direction == CursorDirection.LEFT) {
      updatedX -= step;
    }

    return Coordinates(updatedX, updatedY);
  }
}