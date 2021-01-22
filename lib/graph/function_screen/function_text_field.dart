import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../function_screen/function_display_controller.dart';

class FunctionTextField extends StatefulWidget { 
  final int index;
  final FunctionDisplayController controller;
  FunctionTextField(this.index, this.controller);

  @override
  _FunctionTextFieldState createState() => _FunctionTextFieldState();
}

class _FunctionTextFieldState extends State<FunctionTextField> {

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
        textController.text = widget.controller.getInput(widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        return null;
      },
    );
  }
}
