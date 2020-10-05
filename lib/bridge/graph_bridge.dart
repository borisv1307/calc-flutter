// For C/Rust
import 'dart:ffi';

import 'dart:io';

import 'dart:typed_data';

typedef calc_points = Pointer<Pointer<Float>> Function(Float xl, Float xu,Float yl, Float yu, Float p);
// For Dart
typedef CalcPoints = Pointer<Pointer<Float>> Function(double xl, double xu,double yl, double yu, double p);

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

  List<List<double>> retrieve(double minX, double maxX, double minY, double maxY, double precision){
    final CalcPoints calcPoints = _retrieveFunction();
    var points = calcPoints(minX,maxX,minY,maxY,precision);
    int listSize = ((maxX- minX) +1).round();
    Float32List xCoords = points.elementAt(0).value.asTypedList(listSize);
    Float32List yCoords = points.elementAt(1).value.asTypedList(listSize);

    List<List<double>> coordinates = [];
    for(int i=0;i<listSize;i++){
      if(!xCoords.elementAt(i).isNaN && !yCoords.elementAt(i).isNaN){
        coordinates.add([xCoords.elementAt(i), yCoords.elementAt(i)]);
      }
    }

    return coordinates;
  }
}