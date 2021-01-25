import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:advanced_calculation/advanced_calculator.dart';

class FunctionTextField extends StatefulWidget { 
  final int index;
  final FunctionDisplayController controller;
  final AdvancedCalculator calculator;
  FunctionTextField(this.index, this.controller, [AdvancedCalculator calculator]) :
    calculator = calculator ?? AdvancedCalculator();

  @override
  _FunctionTextFieldState createState() => _FunctionTextFieldState();
}

class _FunctionTextFieldState extends State<FunctionTextField> {

  List<InputItem> inputItems;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    widget.controller?.addListener(_updateFunction);
    _updateFunction();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateFunction);
    textController.dispose();
    super.dispose();
  }

  void _updateFunction() {
    setState(() {
      if (widget.index < widget.controller.inputs.length) {
        inputItems = widget.controller.getInputItems(widget.index);
        textController.text = inputItems.map((e) => e.display).join();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String backendString = inputItems.map((e) => e.value).join();

    return TextFormField(
      controller: textController,
      showCursor: false,
      readOnly: true,
      onTap: () => widget.controller.currentField = widget.index,
      decoration: InputDecoration(
          labelText: 'y' + (widget.index + 1).toString() + '= '
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        if(!widget.calculator.validateEquation(backendString)) return 'Syntax Error';
        return null;
      },
    );
  }
}
