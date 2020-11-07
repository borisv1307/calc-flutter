import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

class CalculatorDisplay extends StatefulWidget {
  final int numLines;
  final CalculatorDisplayController controller;
  CalculatorDisplay(this.controller,{
    this.numLines = 8,
  }) : assert(numLines>1);

  @override
  State<StatefulWidget> createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  static const int CURSOR_INTERVAL = 500;
  static const String CURSOR = '█';
  static const String BLANK = '⠀';
  static const double LINE_HEIGHT = 1.2;
  static const double FONT_SIZE = 22;
  static const TextStyle TEXT_STYLE = TextStyle(height:LINE_HEIGHT,fontSize: FONT_SIZE, color:Colors.black);
  static const Color GREEN = Color.fromRGBO(170, 200, 154, 1);
  Timer _cursorTimer;
  TextEditingController inputLineController = TextEditingController();
  int cursorLocation = -1;


  void _updateInputLine(){
    setState(() {
      this.inputLineController.text = this.widget.controller.inputLine + CURSOR;
    });
  }

  @override
  void initState() {
    super.initState();
    this.inputLineController.text = this.widget.controller.inputLine + CURSOR;
    widget.controller?.addListener(_updateInputLine);
    startCursor();
  }

  @override
  void didUpdateWidget(CalculatorDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cursorTimer.cancel();
    this.inputLineController.text = this.widget.controller.inputLine + CURSOR;
    startCursor();
    if(oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_updateInputLine);
      widget.controller?.addListener(_updateInputLine);
    }
  }

  @override
  void dispose(){
    widget.controller?.removeListener(_updateInputLine);
    _cursorTimer.cancel();
    super.dispose();
  }

  void startCursor(){
    _cursorTimer = Timer.periodic(Duration(milliseconds: CURSOR_INTERVAL), (timer) {
      setState(() {
        if(inputLineController.text.contains(CURSOR)){
          inputLineController.text = inputLineController.text.replaceAll(CURSOR, BLANK);
        }else{
          inputLineController.text = inputLineController.text.replaceAll(BLANK, CURSOR);
        }
      });
    });
  }

  Widget _buildText(String text, Alignment alignment){
    return Align(alignment:alignment,child: Text(text, style: TEXT_STYLE));
  }

  List<Widget> generateRows(DisplayHistory history){
    List<Widget> rows = [
      if(history.input != null)
        _buildText(history.input, Alignment.centerLeft),
      if(history.result != null)
        _buildText(history.result, Alignment.centerRight)
    ];

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> history = this.widget.controller.history.map(generateRows).expand((i) => i).toList();
    history.add(Align(alignment:Alignment.centerLeft,
        child: Material(
          color: GREEN,
          child:TextField(
            readOnly: true,
            showCursor: false,
            textInputAction: TextInputAction.none,
            controller: inputLineController,
            onTap: (){
              //update cursor
            },
            decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
            ),
            style: TEXT_STYLE)
        )
      )
    );
    ScrollController controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });

    return Container(
      color: GREEN,
      padding: EdgeInsets.all(12),
      child: SizedBox(
        height: LINE_HEIGHT * FONT_SIZE * this.widget.numLines,
        child: SingleChildScrollView(
          //reverse: true,
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: history
            )
          )
        )
      )
    );
  }
}
