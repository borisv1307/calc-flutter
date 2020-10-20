import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_calc/calculator_display/display_history.dart';

class CalculatorDisplay extends StatefulWidget {
  final String inputLine;
  final List<DisplayHistory> history;
  CalculatorDisplay(this.inputLine, this.history);

  @override
  State<StatefulWidget> createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  String display;
  static const String CURSOR = '█';
  static const String BLANK = '⠀';
  Timer cursorTimer;


  @override
  void initState() {
    super.initState();
    this.display = this.widget.inputLine + CURSOR;
    startCursor();
  }

  @override
  void didUpdateWidget(CalculatorDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    cursorTimer.cancel();
    this.display = this.widget.inputLine + CURSOR;
    startCursor();
  }

  @override
  void dispose(){
    cursorTimer.cancel();
    super.dispose();
  }

  void startCursor(){
    cursorTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if(display.contains(CURSOR)){
          display = display.replaceAll(CURSOR, BLANK);
        }else{
          display = display.replaceAll(BLANK, CURSOR);
        }
      });
    });
  }

  List<Widget> generateRows(DisplayHistory history){
    List<Widget> rows = [
      if(history.input != null)
        Align(alignment:Alignment.centerLeft,child: Text(history.input, style: TextStyle(height:1.2,fontSize: 24),)),
      if(history.result != null)
        Align(alignment:Alignment.centerRight,child: Text(history.result, style: TextStyle(height:1.2,fontSize: 24),))
    ];

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> history = this.widget.history.map(generateRows).expand((i) => i).toList();
    history.add(Align(alignment:Alignment.centerLeft,child: Text(display, style: TextStyle(height:1.2,fontSize: 24),)));

    ScrollController controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });

    return Container(
        color: Color.fromRGBO(170, 200, 154, 1),
        child:SizedBox(
          width:double.maxFinite,
          child: SingleChildScrollView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              child:Container(
                padding: EdgeInsets.all(12),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:history
                  )
              ))
          ));
  }
}
