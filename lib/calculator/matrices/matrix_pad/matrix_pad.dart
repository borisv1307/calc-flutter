import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/matrices/matrix_pad/matr_primary_pad.dart';
import 'package:open_calc/calculator/matrices/matrix_pad/matr_secondary_pad.dart';
import 'package:open_calc/calculator/matrices/matrix_pad/matrix_command_handler.dart';

// ignore: must_be_immutable
class MatrixInputPad extends StatelessWidget{

  final CalculatorDisplayController controller;
  final List<List<String>> matrix;
  final int xIndex;
  final int yIndex;
  MatrixCommandHandler handler;
  InputHandler inputHandler;
  final BuildContext context;
  final Function func;

  MatrixInputPad(this.controller,this.matrix,this.xIndex,this.yIndex,this.context, this.func){
  
    handler = MatrixCommandHandler(controller, matrix, xIndex, yIndex, context,func);
    inputHandler = InputHandler(controller);
  }

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'matrPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'matrPadOne':
            builder = (BuildContext context) => MatrixPrimaryPad(inputHandler.handle, handler.handle);
            break;
          case 'matrPadTwo':
            builder = (BuildContext context) => MatrixSecondaryPad(inputHandler.handle, handler.handle);
            break;
      }
        return MaterialPageRoute(builder: builder, settings: settings);
    });
  }
}