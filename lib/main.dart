import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:open_calc/home_screen.dart';

void main() {
  runApp(MyApp());
}

// For C/Rust
typedef add_func = Int64 Function(Int64 a, Int64 b);
// For Dart
typedef Add = int Function(int a, int b);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final DynamicLibrary addNative = Platform.isAndroid
        ? DynamicLibrary.open("libadder_ffi.so")
        : DynamicLibrary.process();

    final Add add = addNative
        .lookup<NativeFunction<add_func>>("add")
        .asFunction();

  print(add(2,2));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(title: 'Graphing Demo'),
    );
  }
}

