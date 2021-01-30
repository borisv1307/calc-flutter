import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/coordinates.dart';

class GraphCursor {
    double x;  // pixel coordinates of cursor
    double y;
    Bounds _graphBounds; 
    final double _xPixels;  // graph dimensions in pixel units
    final double _yPixels;

    GraphCursor(this._xPixels, this._yPixels, this._graphBounds) {
      moveToCoordinates(0, 0);
    }

    Coordinates coordinates() {
      return Coordinates(x, y);
    }

    // update bounds and move cursor to new position
    set bounds(Bounds newBounds) {
      double xValue = getXValue();
      double yValue = getYValue();
      _graphBounds = newBounds;
      moveToCoordinates(xValue, yValue);  // update cursor position for new bounds
    }

    // calculate graph x value of cursor
    double getXValue() {
      double value = x - (_xPixels / 2);
      double scale = _xPixels / (_graphBounds.xMax - _graphBounds.xMin);
      return num.parse((value/scale).toStringAsFixed(4));
    }

    // calculate graph y value of cursor
    double getYValue() {
      double value = y - (_yPixels / 2);
      double scale = _yPixels / (_graphBounds.yMax - _graphBounds.yMin);
      return num.parse((value/scale).toStringAsFixed(4));
    }

    // move 1 unit in a given direction
    void move(String direction) {
      if (direction == "UP") {
        y += _yPixels / (_graphBounds.yMax - _graphBounds.yMin);
      } else if (direction == "DOWN") {
        y -= _yPixels / (_graphBounds.yMax - _graphBounds.yMin);
      } else if (direction == "RIGHT") {
        x += _xPixels / (_graphBounds.xMax - _graphBounds.xMin);
      } else if (direction == "LEFT") {
        x -= _xPixels / (_graphBounds.xMax - _graphBounds.xMin);
      }
  }

  // move cursor to given x,y graph coordinates
  void moveToCoordinates(double newX, double newY) {
    this.x = _xPixelValue(newX);
    this.y = _yPixelValue(newY);
  }

  // calculate pixel location for given x value
  double _xPixelValue(double newX) {
    double pixelValue = newX * (_xPixels / (_graphBounds.xMax - _graphBounds.xMin));
    return pixelValue + (_xPixels / 2);
  }

  // calculate pixel location for given y value
  double _yPixelValue(double newY) {
    double pixelValue = newY * (_yPixels / (_graphBounds.yMax - _graphBounds.yMin));
    return pixelValue + (_yPixels / 2);
  }
}