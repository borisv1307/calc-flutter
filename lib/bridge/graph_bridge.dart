import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'package:cartesian_graph/coordinates.dart';

class CoordPair extends Struct {
  // ignore: non_constant_identifier_names
  Pointer<Double> x_ptr;
  // ignore: non_constant_identifier_names
  Pointer<Double> y_ptr;
}

typedef graph_func = Pointer<CoordPair> Function(Pointer<Utf8> expr, Double xl, Double xu, Double yl, Double yu, Double xp, Double yp);
typedef GraphFunction = Pointer<CoordPair> Function(Pointer<Utf8> expr, double xl, double xu, double yl, double yu, double xp, double yp);
typedef calc_func = Double Function(Pointer<Utf8>);
typedef CalcFunction = double Function(Pointer<Utf8>);

class GraphBridge {
  GraphFunction _add;
  CalcFunction _result;

  static final GraphBridge _singleton = GraphBridge._internal();

  factory GraphBridge() {
    return _singleton;
  }

  GraphBridge._internal();

  GraphFunction _retrieveGraphFunction() {
    if (_add == null) {
      final DynamicLibrary addNative = Platform.isAndroid
          ? DynamicLibrary.open("libcalc_2.so")
          : DynamicLibrary.process();

      _add = addNative
          .lookup<NativeFunction<graph_func>>("coord_vector_maker")
          .asFunction<GraphFunction>();
    }
    return _add;
  }

  CalcFunction _retrieveCalcFunction() {
    if (_result == null) {
      final DynamicLibrary addNative = Platform.isAndroid
          ? DynamicLibrary.open("libcalc_2.so")
          : DynamicLibrary.process();

      _result = addNative
          .lookup<NativeFunction<calc_func>>("calculate")
          .asFunction<CalcFunction>();
    }
    return _result;
  }

  List<Coordinates> retrieveGraph(String expr1, String expr2, String expr3, double minX, double maxX, double minY, double maxY, [double xPrecision = 1, double yPrecision = 1]) {
    final GraphFunction calcPoints = _retrieveGraphFunction();
    Pointer<CoordPair> points1 = calcPoints(Utf8.toUtf8(expr1), minX, maxX, minY, maxY, xPrecision, yPrecision);
    Pointer<CoordPair> points2 = calcPoints(Utf8.toUtf8(expr2), minX, maxX, minY, maxY, xPrecision, yPrecision);
    Pointer<CoordPair> points3 = calcPoints(Utf8.toUtf8(expr3), minX, maxX, minY, maxY, xPrecision, yPrecision);

    int listSize = ((maxX - minX) + 1).round();
    Float64List xCoords1 = points1.ref.x_ptr.asTypedList(listSize);
    Float64List yCoords1 = points1.ref.y_ptr.asTypedList(listSize);
    Float64List xCoords2 = points2.ref.x_ptr.asTypedList(listSize);
    Float64List yCoords2 = points2.ref.y_ptr.asTypedList(listSize);
    Float64List xCoords3 = points3.ref.x_ptr.asTypedList(listSize);
    Float64List yCoords3 = points3.ref.y_ptr.asTypedList(listSize);

    List<Coordinates> coordinates = [];
    for (int i = 0; i < listSize; i++) {
      if (!xCoords1.elementAt(i).isNaN && !yCoords1.elementAt(i).isNaN) {
        coordinates
            .add(Coordinates(xCoords1.elementAt(i), yCoords1.elementAt(i)));
      }
      if (!xCoords2.elementAt(i).isNaN && !yCoords2.elementAt(i).isNaN) {
        coordinates
            .add(Coordinates(xCoords2.elementAt(i), yCoords2.elementAt(i)));
      }
      if (!xCoords3.elementAt(i).isNaN && !yCoords3.elementAt(i).isNaN) {
        coordinates
            .add(Coordinates(xCoords3.elementAt(i), yCoords3.elementAt(i)));
      }
    }
    return coordinates;
  }

  double retrieveCalculatorResult(String expression) {
    print(expression);
    final CalcFunction calcExpression = _retrieveCalcFunction();
    Pointer<Utf8> exprPtr = Utf8.toUtf8(expression);
    double result = calcExpression(exprPtr);
    return result;
  }
}
