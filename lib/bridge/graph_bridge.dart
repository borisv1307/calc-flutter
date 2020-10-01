// For C/Rust
import 'dart:ffi';

import 'dart:io';

typedef add_func = Int64 Function(Int64 a, Int64 b);
// For Dart
typedef Add = int Function(int a, int b);

class GraphBridge {
  Add _add;

  static final GraphBridge _singleton = GraphBridge._internal();

  factory GraphBridge() {
    return _singleton;
  }

  GraphBridge._internal();

  Add _retrieveFunction(){
     if(_add == null){
      final DynamicLibrary addNative = Platform.isAndroid
          ? DynamicLibrary.open("libadder_ffi.so")
          : DynamicLibrary.process();

      _add = addNative
          .lookup<NativeFunction<add_func>>("add")
          .asFunction();
    }
    return _add;
  }

  void retrieve(){
    final Add add = _retrieveFunction();

    print(add(2,2));
  }
}