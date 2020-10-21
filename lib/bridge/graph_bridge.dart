import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cartesian_graph/coordinates.dart';


class CoordPair extends Struct{
  // ignore: non_constant_identifier_names
  Pointer<Float> x_ptr;
  // ignore: non_constant_identifier_names
  Pointer<Float> y_ptr;
}

typedef calc_points = Pointer<CoordPair> Function(Float xl, Float xu,Float yl, Float yu, Float xp,Float yp);
typedef CalcPoints = Pointer<CoordPair> Function(double xl, double xu,double yl, double yu, double xp, double yp);

class GraphBridge {
  CalcPoints _add;

  static final GraphBridge _singleton = GraphBridge._internal();

  factory GraphBridge() {
    return _singleton;
  }

  GraphBridge._internal();

  CalcPoints _retrieveFunction(){
     if(_add == null){
      final DynamicLibrary addNative = Platform.isAndroid
          ? DynamicLibrary.open("libcalc_2.so")
          : DynamicLibrary.process();

      _add = addNative
          .lookup<NativeFunction<calc_points>>("coord_vector_maker")
          .asFunction();
    }
    return _add;
  }
  
  List<Coordinates> retrieve(double minX, double maxX, double minY, double maxY, [double xPrecision=1, double yPrecision=1]){
    final CalcPoints calcPoints = _retrieveFunction();
    Pointer<CoordPair> points = calcPoints(minX,maxX,minY,maxY,xPrecision,yPrecision);
    int listSize = ((maxX- minX) +1).round();
    Float32List xCoords = points.ref.x_ptr.asTypedList(listSize);
    Float32List yCoords = points.ref.y_ptr.asTypedList(listSize);

    List<Coordinates> coordinates = [];
    for(int i=0;i<listSize;i++){
      if(!xCoords.elementAt(i).isNaN && !yCoords.elementAt(i).isNaN){
        coordinates.add(Coordinates(xCoords.elementAt(i), yCoords.elementAt(i)));
      }
    }

    return coordinates;
  }
}