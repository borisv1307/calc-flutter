import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';

class FunctionTextField extends StatefulWidget {
  final int index;
  final FunctionDisplayController controller;
  final AdvancedCalculator calculator;
  FunctionTextField(this.index, this.controller,
      [AdvancedCalculator calculator])
      : calculator = calculator ?? AdvancedCalculator();

  @override
  _FunctionTextFieldState createState() => _FunctionTextFieldState();
}

class _FunctionTextFieldState extends State<FunctionTextField> {
  List<InputItem> inputItems;
  TextEditingController textController;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    widget.controller?.addListener(_updateFunction);
    focusNode = FocusNode();
    _updateFunction();
  }

  @override
  void didUpdateWidget(FunctionTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_updateFunction);
      widget.controller.addListener(_updateFunction);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateFunction);
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _updateFunction() {
    setState(() {
      if (widget.index < widget.controller.inputs.length) {
        inputItems = widget.controller.getInputItems(widget.index);
        textController.text = inputItems.map((e) => e.display).join();
      }
    });
    focusNode.requestFocus();
    // focusNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    String backendString = inputItems.map((e) => e.value).join();

    return TextFormField(
      // autofocus: true,
      focusNode: focusNode,
      controller: textController,
      style: TextStyle(fontFamily: 'RobotoMono', fontSize: 23),
      showCursor: false,
      readOnly: true,
      onTap: () => widget.controller.currentField = widget.index,
      decoration: InputDecoration(
          prefix: Text(""),
          contentPadding:
              new EdgeInsets.only(bottom: 14, top: 14, left: 20, right: 20),
          border:
              OutlineInputBorder(borderRadius: new BorderRadius.circular(10)),
          fillColor: Colors.white,
          filled: true,
          errorStyle: TextStyle(fontSize: 14)),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        if (!widget.calculator.validateEquation(backendString))
          return 'Syntax Error';
        return null;
      },
    );
  }
}
