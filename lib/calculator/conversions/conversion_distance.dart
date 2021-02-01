import 'package:flutter/material.dart';
import 'package:open_calc/calculator/conversions/conversion_options.dart';


class DistanceConvert extends StatefulWidget{

  DistanceConvert();
  State<StatefulWidget> createState() => DistanceConvertState();
}

class DistanceConvertState extends State<DistanceConvert>{

  DistanceConvertState();

  ConversionOptions convert = new ConversionOptions();

  String defaultDropVal = 'meters';
  String defaultDropVal2 = 'kilometers';
  String locationalDropVal = 'Distance';

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  Widget build(BuildContext context){
    return
    Container(
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(
      color:Colors.black,
      width: 1,
      ),
      borderRadius: BorderRadius.circular(25.0)),
      child:
    ListView(
      shrinkWrap: true,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
        child:
          InkWell(child: Icon(Icons.arrow_back,color: Colors.black,size: 30.0,),
            onTap: () {setState((){
              Navigator.of(context).pushNamed("Temp");
            });
            })),
        Text('Distance', textAlign: TextAlign.center),
        Container(
        child:
          InkWell(child: Icon(Icons.arrow_forward,color: Colors.black,size: 30.0,),
            onTap: () {setState((){
              Navigator.of(context).pushNamed("Temp");
            });
            })),
      ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Expanded(child:
        Container(
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(
          color:Colors.black,
          width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
          ),
        child:
        DropdownButton<String>(
          value: defaultDropVal,
          isDense: true,
          style: TextStyle(color: Colors.black38),
          onChanged: (String newValue) {
            setState((){
              defaultDropVal = newValue;
            });
          },
          items: convert.distanceList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(value: value, child: Text(value),
            );
          }).toList(),
        ),
        ))]),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Expanded(child:
        Container(
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(
          color:Colors.black,
          width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
          ),
        child:
        TextField(
          controller: _textFieldController,
          keyboardType: TextInputType.numberWithOptions(),
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: InputBorder.none, hintText: 'Input'),
        )),
        )]),
        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Icon(
          Icons.transform,
          color: Colors.black,
          size: 30.0,
        ),
        ]),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Expanded(child:
        Container(
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(
          color:Colors.black,
          width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
          ),
        child:
        DropdownButton<String>(
          value: defaultDropVal2,
          isDense: true,
          style: TextStyle(color: Colors.black38),
          onChanged: (String newValue) {
            setState((){
              defaultDropVal2 = newValue;
            });
          },
          items: convert.distanceList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(value: value, child: Text(value),
            );
          }).toList(),
        ),
        ))]),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Expanded(child:
        Container(
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(
          color:Colors.black,
          width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
          ),
        child:
        TextField(
          controller: _textFieldController2,
          keyboardType: TextInputType.numberWithOptions(),
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: InputBorder.none, hintText: 'Output'),
        )),
        )],),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        FlatButton(
                child: new Text('Back'),
                onPressed: () {
                  Navigator.of(context).pushNamed('inputPadTwo');
                },
              )
      ],)
    ],));
  }
}