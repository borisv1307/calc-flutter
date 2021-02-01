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

    get xWidth {
      return _graphBounds.xMax - _graphBounds.xMin;
    }

    get yWidth {
      return _graphBounds.yMax - _graphBounds.yMin;
    }

    // calculate graph x value of cursor
    double getXValue() {
      double value = x - _xPixels / (xWidth / (0 - _graphBounds.xMin));
      double scale = _xPixels / xWidth;
      return num.parse((value/scale).toStringAsFixed(4));
    }

    // calculate graph y value of cursor
    double getYValue() {
      double value = y - _yPixels / (yWidth / (0 - _graphBounds.yMin));
      double scale = _yPixels / yWidth;
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
    double pixelValue = newX * (_xPixels / xWidth);
    return pixelValue + _xPixels / (xWidth/ (0 - _graphBounds.xMin));
  }

  // calculate pixel location for given y value
  double _yPixelValue(double newY) {
    double pixelValue = newY * (_yPixels / yWidth);
    return pixelValue + _yPixels / (yWidth / (0 - _graphBounds.yMin));
  }
}