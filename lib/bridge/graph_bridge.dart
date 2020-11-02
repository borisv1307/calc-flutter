import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'package:cartesian_graph/coordinates.dart';

class CoordPair extends Struct {
  // ignore: non_constant_identifier_names
  Pointer<Float> x_ptr;
  // ignore: non_constant_identifier_names
  Pointer<Float> y_ptr;
}

typedef graph_function = Pointer<CoordPair> Function(Pointer<Utf8> expr, Float xl, Float xu, Float yl, Float yu, Float xp, Float yp);
typedef GraphFunction = Pointer<CoordPair> Function(Pointer<Utf8> expr, double xl, double xu, double yl, double yu, double xp, double yp);
typedef CalcFunction = Pointer<Utf8> Function(Pointer<Utf8>);

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
          .lookup<NativeFunction<graph_function>>("coord_vector_maker")
          .asFunction();
    }
    return _add;
  }

  CalcFunction _retrieveCalcFunction() {
    if (_result == null) {
      final DynamicLibrary addNative = Platform.isAndroid
          ? DynamicLibrary.open("libcalc_2.so")
          : DynamicLibrary.process();

      _result = addNative
          .lookup<NativeFunction<CalcFunction>>("calculate")
          .asFunction();
    }
    return _result;
  }

  List<Coordinates> retrieveGraph(double minX, double maxX, double minY, double maxY, String functionY, [double xPrecision = 1, double yPrecision = 1]) {
    final GraphFunction calcPoints = _retrieveGraphFunction();
    String expression = functionY; //"0.05 * x^2";  // hard-coded
    Pointer<CoordPair> points = calcPoints(Utf8.toUtf8(expression), minX, maxX, minY, maxY, xPrecision, yPrecision);
    int listSize = ((maxX - minX) + 1).round();
    Float32List xCoords = points.ref.x_ptr.asTypedList(listSize);
    Float32List yCoords = points.ref.y_ptr.asTypedList(listSize);

    List<Coordinates> coordinates = [];
    for (int i = 0; i < listSize; i++) {
      if (!xCoords.elementAt(i).isNaN && !yCoords.elementAt(i).isNaN) {
        coordinates
            .add(Coordinates(xCoords.elementAt(i), yCoords.elementAt(i)));
      }
    }
    return coordinates;
  }

  String retrieveCalculatorResult(String expression) {
    print(expression);
    final CalcFunction calcExpression = _retrieveCalcFunction();
    Pointer<Utf8> exprPtr = Utf8.toUtf8(expression);
    Pointer<Utf8> resultPtr = calcExpression(exprPtr);
    String result = Utf8.fromUtf8(resultPtr);
    return result;
  }
}
