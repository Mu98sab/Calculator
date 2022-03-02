import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:calculator/light_mood.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Rajdhani", 
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  List<List<Object>> buttons = [
    ["AC" , "C", "^", "÷"],
    ["7"  , "8", "9", "×"],
    ["4"  , "5", "6", "-"],
    ["1"  , "2", "3", "+"],
    ["%", "0", ".", "="]    
  ];

  String _expr = "";

  String _result = "0";

  var backColor = Color(0xff252422);
  var subColor  = Color(0xff333533); 
  var fontColor = Color(0xfffefae0);

  void _setExpr(String str) {
    setState(() {
      _expr = str;
    });
  }

  void _setRslt(String str) {
    setState(() {
      _result = str;
    });
  }

  void _light() {
    setState(() {
      backColor = Color(0xfffffcf2);
      subColor  = Color(0xffccb7ae);
      fontColor = Color(0xff252422);
    });
    
  }

  void _night() {
    setState(() {
      backColor = Color(0xff252422);
      subColor  = Color(0xff333533); 
      fontColor = Color(0xfffefae0);
    });
  } 

  String eval(String expression) {

    List<String> expr = expression.trim().split(" ");
    if (expr.length == 1) {
      return expr[0];
    }

    if (expr.length % 2 == 0) {
      return "Error";
    }
    
    
    num result = 0;

    
    result = calc(num.parse(expr[0]), num.parse(expr[2]), expr[1]);
    
    if (expr.length > 3) {
      for (int i = 3; i < expr.length; i += 2) {
        result = calc(result, num.parse(expr[i+1]), expr[i]);
      }
    }
    return "$result";

  }

  num calc(num x, num y, String opr) {
    if (opr == "+") {
      return x + y;  
    }
    else if (opr == "-") {
      return x - y;
    }
    else if (opr == "×") {
      return x * y;
    }
    else if (opr == "÷") {
      return x / y;
    }
    return pow(x, y);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        body: Column(
          children: [
            LightMode(
              font: fontColor,
              light: _light,
              night: _night,
              sub: subColor,
            ),

            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    _expr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 35
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    _result,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 55
                    ),
                  ),
                ),
              ),
            ),

            CalcBtns(
              back: backColor,
              eval: eval,
              font: fontColor,
              sub: subColor,
              exprF: _setExpr,
              resultF: _setRslt,
            ),

          ],
        ),
      ),
    );
  }
}

