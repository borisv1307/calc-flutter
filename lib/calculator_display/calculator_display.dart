import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_calc/calculator_display/display_history.dart';

class CalculatorDisplay extends StatefulWidget {
  final int numLines;
  final String inputLine;
  final List<DisplayHistory> history;
  CalculatorDisplay(this.numLines, {this.inputLine='', this.history= const []}):
      assert(numLines>1);

  @override
  State<StatefulWidget> createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  String _display;
  static const int CURSOR_INTERVAL = 500;
  static const String CURSOR = '█';
  static const String BLANK = '⠀';
  static const double LINE_HEIGHT = 1.2;
  static const double FONT_SIZE = 22;
  static const TextStyle TEXT_STYLE = TextStyle(height:LINE_HEIGHT,fontSize: FONT_SIZE);
  Timer _cursorTimer;


  @override
  void initState() {
    super.initState();
    this._display = this.widget.inputLine + CURSOR;
    startCursor();
  }

  @override
  void didUpdateWidget(CalculatorDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cursorTimer.cancel();
    this._display = this.widget.inputLine + CURSOR;
    startCursor();
  }

  @override
  void dispose(){
    _cursorTimer.cancel();
    super.dispose();
  }

  void startCursor(){
    _cursorTimer = Timer.periodic(Duration(milliseconds: CURSOR_INTERVAL), (timer) {
      setState(() {
        if(_display.contains(CURSOR)){
          _display = _display.replaceAll(CURSOR, BLANK);
        }else{
          _display = _display.replaceAll(BLANK, CURSOR);
        }
      });
    });
  }

  Widget _buildText(String text, Alignment alignment){
    return Align(alignment:alignment,child: Text(text, style: TEXT_STYLE));
  }

  List<Widget> generateRows(DisplayHistory history){
    List<Widget> rows = [
      if(history.input != null && history.input.isNotEmpty)
        _buildText(history.input, Alignment.centerLeft),
      if(history.result != null)
        _buildText(history.result, Alignment.centerRight)
    ];

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> history = this.widget.history.map(generateRows).expand((i) => i).toList();
    history.add( _buildText(_display, Alignment.centerLeft));
    ScrollController controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });

    return Container(
        color: Color.fromRGBO(170, 200, 154, 1),
        padding: EdgeInsets.all(12),
        child:SizedBox(
            height: LINE_HEIGHT * FONT_SIZE * this.widget.numLines,
            child: SingleChildScrollView(
              //reverse: true,
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              child:Container(
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:history
                  )
              ))
          ));
  }
}
