import 'package:cartesian_graph/coordinates.dart';


class GraphCursor {
  double x;
  double y;
  double step;

  GraphCursor([this.x = 0, this.y = 0, this.step = 1]);

  Coordinates coordinates() {
    return Coordinates(x, y);
  }

  // move 1 step in a given direction
  void move(String direction) {
    if (direction == "UP") {
      y += step;
    } else if (direction == "DOWN") {
      y -= step;
    } else if (direction == "RIGHT") {
      x += step;
    } else if (direction == "LEFT") {
      x -= step;
    }
  }

  void moveToCoordinates(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
