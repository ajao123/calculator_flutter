import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    home: HOME(),
  ));
}

class HOME extends StatefulWidget {
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  List _toDoListOperations = [];
  final calculadoraController = TextEditingController();

  void _addToDo(String operation){
    setState(() {
      _toDoListOperations.add(operation+calculadoraController.text);
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async{
    String data = json.encode(_toDoListOperations);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();

      return file.readAsString();
    }catch(e){
      return null;
    }
  }


  double calcular(String expression){
    expression+="@";
    double resultado = 0.0;

    List<String> values = expression.split("");
    List<double> numbers = new List();
    List<String> simbols = new List();

    int initial = 0;

    for(int i = 0; i < values.length; i++){
      if(values[i] == "+" ||
          values[i] == "-" ||
          values[i] == "x" ||
          values[i] == "/" ||
          values[i] == "%" ||
          values[i] == "@"){
        numbers.add(double.parse(expression.substring(initial, i)));
        simbols.add(values[i]);
        initial = i+1;
      }
    }

    for(int i = 0; i < simbols.length; i++){
      if(simbols[i] == "-"){
        simbols[i]="+";
        numbers[i+1] = -numbers[i+1];
      }
    }

    for(int i = 0; i < simbols.length; i++){
      if(simbols[i] == "/"){
        simbols[i]="+";
        double div = numbers[i]/numbers[i+1];
        numbers[i] = 0.0;
        numbers[i+1] = div;
      }
      if(simbols[i] == "x"){
        simbols[i]="+";
        double mul = numbers[i]*numbers[i+1];
        numbers[i] = 0.0;
        numbers[i+1] = mul;
      }
      if(simbols[i] == "%"){
        simbols[i]="+";
        double rst = numbers[i]%numbers[i+1];
        numbers[i] = 0.0;
        numbers[i+1] = rst;
      }

    }



    for(double i in numbers){
      resultado+=i;
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child:ListView.builder(
                  itemCount: _toDoListOperations.length,
                  itemBuilder: (context, index){
                    return Container(
                      child:
                      Text(_toDoListOperations[index], style:
                      TextStyle(color: Colors.greenAccent, fontSize: 40.0),textAlign: TextAlign.center,),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: new Border.all(color: Colors.black),
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              )
          ),

          Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                height: 100.0,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: buildTextFields(
                    "",
                    InputBorder.none,
                    false,
                    new BorderRadius.circular(30.0),
                    EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    calculadoraController
                ),
              )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"1";
                    },
                    color: Colors.green,
                    child: Text("1",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"2";
                    },
                    color: Colors.green,
                    child: Text("2",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"3";
                    },
                    color: Colors.green,
                    child: Text("3",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"+";
                    },
                    color: Colors.green,
                    child: Text("+",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"4";
                    },
                    color: Colors.green,
                    child: Text("4",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"5";
                    },
                    color: Colors.green,
                    child: Text("5",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"6";
                    },
                    color: Colors.green,
                    child: Text("6",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"-";
                    },
                    color: Colors.green,
                    child: Text("-",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"7";
                    },
                    color: Colors.green,
                    child: Text("7",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"8";
                    },
                    color: Colors.green,
                    child: Text("8",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"9";
                    },
                    color: Colors.green,
                    child: Text("9",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"x";
                    },
                    color: Colors.green,
                    child: Text("x",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"0";
                    },
                    color: Colors.green,
                    child: Text("0",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = "";
                    },
                    color: Colors.green,
                    child: Text("C",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      List<String> values = calculadoraController.text.split("");
                      String msgs = "";
                      for(int i = 0; i < values.length-1; i++){
                        msgs+=values[i];
                      }
                      calculadoraController.text = msgs;
                    },
                    color: Colors.green,
                    child: Text("CE",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"/";
                    },
                    color: Colors.green,
                    child: Text("/",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(

                  width: MediaQuery.of(context).size.width/2.2,
                  height: 50.0,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: (){
                      String operations = calculadoraController.text;
                      calculadoraController.text = calcular(calculadoraController.text).toString();
                      _addToDo(operations+" = ");
                    },
                    color: Colors.green,
                    child: Text("=",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      calculadoraController.text = calculadoraController.text+"%";
                    },
                    color: Colors.green,
                    child: Text("%",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/4.5,
                  child: RaisedButton(
                    onPressed: (){
                      setState(() {
                        _toDoListOperations = [];
                      });
                    },
                    color: Colors.green,
                    child: Text("E",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
              ),

            ],
          ),

        ],
      )
        ,)
    );
  }
}

Widget buildTextFields(
    String hintText,
    InputBorder border,
    bool obscureText,
    BorderRadius borderRadius,
    EdgeInsets edgeInsets,
    TextEditingController resultController,
    ) {
  return Padding(
      padding: edgeInsets,
      child: Container(
        padding: edgeInsets,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: borderRadius
        ),
        child: new TextFormField(
          textAlign: TextAlign.center,
          controller: resultController,
          keyboardType: TextInputType.number,
          obscureText: obscureText,
          style: TextStyle(fontSize: 30.0),
          decoration: InputDecoration(
            hintText: hintText,
            border: border,
          ),
        ),
      ));
}