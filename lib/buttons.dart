import 'dart:math';

import 'package:flutter/material.dart';

class CalcBtns extends StatefulWidget {
  CalcBtns({ 
    Key key,
    @required this.font,
    @required this.sub,
    @required this.back,
    @required this.eval,
    @required this.exprF,
    @required this.resultF,
  }) : super(key: key);

  final Color sub, font, back;
  final Function eval, exprF, resultF;
  
  @override
  _CalcBtnsState createState() => _CalcBtnsState();
}

class _CalcBtnsState extends State<CalcBtns> {
  List<List<Object>> _buttons = [
    ["AC" , "C", "^", "÷"],
    ["7"  , "8", "9", "×"],
    ["4"  , "5", "6", "-"],
    ["1"  , "2", "3", "+"],
    ["%", "0", ".", "="]    
  ];

  var clr;
  List<Widget> temp = List.empty();

  Function f;
  String x, expr = "", reslt = "0";
  int size = 28;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.sub,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.23)
          )
        ],
      ),
      child: Column(
        children: List.generate(
          
        _buttons.length, (i) {
          clr = widget.font;
          temp = List();
          
          

          if (i == 0) {
            clr = Colors.lightBlueAccent[400];
            
          }

          for (int j = 0; j < 4; j++) {
            if (j == 3) {
              clr = Colors.deepOrange;
            }
            
            if (_buttons[i][j] == "AC") {
              f = () {
                expr = "";
                reslt = "0";
                widget.exprF(expr);
                widget.resultF(reslt);
              };
            }
            else if (_buttons[i][j] == "C") {
              f = () {
                if (expr != "") {
                  
                  if (expr[expr.length-1] == " "){
                    expr = expr.substring(0, expr.length - 3);
                    widget.exprF(expr);
                  }
                  else {
                    expr = expr.substring(0, expr.length - 1);
                    widget.exprF(expr);
                  }
                
                }
              };
            }
            else if (_buttons[i][j] == "%") {
              f = () {
                try {
                  x = expr.trim()[expr.trim().length - 1];
                }
                catch (err){
                  x = "";
                }
                num res = num.tryParse(reslt);
                if (res == null || res.isInfinite || res.isNaN) {
                  expr = "";
                  reslt = "0";
                  widget.exprF(expr);
                  widget.resultF(reslt);
                }
                
                if (expr == "") {
                  expr += "$reslt ÷ 100";
                  widget.exprF(expr);
                }
                else if (x == "+" || x == "-" || x == "^" || x == "×" || x == "÷") {
                  expr = expr.substring(0, expr.length - 2) + "÷ 100";
                  widget.exprF(expr);
                }
                else {
                  expr += " ÷ 100";
                  widget.exprF(expr); 
                }
              };
            }
            else if (_buttons[i][j] == "=") {
              f = () {
                reslt = widget.eval(expr);
                widget.resultF(reslt);
              };
            }
            else if (_buttons[i][j] == "^" || _buttons[i][j] == "÷" || _buttons[i][j] == "+" 
                    || _buttons[i][j] == "×" || _buttons[i][j] == "-") {
              f = () {

                num res = num.tryParse(reslt);

                if (res == null || res.isInfinite || res.isNaN) {
                  reslt = "0";
                  expr = "";
                  x = reslt;
                }
                else if (expr == "" || reslt != "0") {
                  expr = "";
                  x = reslt;
                  
                }
                else{
                  
                  try {
                    x = expr.trim()[expr.trim().length - 1];
                    if (x == "+" || x == "-" || x == "^" || x == "×" || x == "÷"){
                      x = expr.substring(0, expr.length - 3);
                    }
                    else {
                      x = expr;
                    }
                  }
                  catch (err) {
                    x = "";
                  }
                  
                }
                
                
                expr = x + " ${_buttons[i][j]} ";
                widget.exprF(expr);
              };
            }
            else{
              f = () {
                expr += _buttons[i][j];
                widget.exprF(expr);
              };
            }


            temp.add(
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                  child: Container(
                    width: 65,
                    height: 60,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.back
                    ),
                    child: Text(
                      _buttons[i][j],
                      style: TextStyle(
                        color: clr,
                        fontSize: 28,
                        fontWeight: (i == 0 || j == 3) ? FontWeight.bold : FontWeight.normal
                      ),
                    ),
                  ),

                  onPressed: f,
                ),
              )
            );
          }
          return temp;
        }
      ).map(
          (e) => Row(
            children: e,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
        ).toList(),
      ),
    );
  }
}