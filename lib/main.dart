import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: SimpleCalculator(),
    );
  }
}

//Stateful widget because we need to get triggered buttons and change result
class SimpleCalculator extends StatefulWidget {
  @override
  SimpleCalculatorState createState() => SimpleCalculatorState();
}

class SimpleCalculatorState extends State<SimpleCalculator> {
  double expressionFontSize = 30.0, resultFontSize = 45.0;
  String result = "0", expression = "0";

  void buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        expression = "0";
        result = "0";
        expressionFontSize = 30.0;
        resultFontSize = 45.0;
      } else if (text == "⌫") {
        if (expression != "") {
          expression = expression.substring(0, expression.length - 1);
        } else
          expression = "0";
        result = "0";
        expressionFontSize = 45.0;
        resultFontSize = 30.0;
      } else if (text == "=") {
        expressionFontSize = 30.0;
        resultFontSize = 45.0;
        try {
          Parser p = Parser();
          Expression parsed = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${parsed.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Something went wrong!";
        }
      } else {
        if (expression == "0")
          expression = text;
        else
          expression += text;
      }
    });
  }

  Widget buildSimpleButton(
      {String text = "",
      double height = 1,
      Color buttonBackgroundColor = Colors.redAccent}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: buttonBackgroundColor, onPrimary: Colors.white),
            onPressed: () => buttonPressed(text),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Simple calculator",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            //Expression container
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              expression,
              style:
                  TextStyle(fontSize: expressionFontSize, color: Colors.white),
            ),
          ),
          Container(
            //Result container
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(child: Divider()),
          Container(
            //buttons grid
            width: MediaQuery.of(context).size.width * 1,
            child: Table(
              children: [
                TableRow(
                  children: [
                    buildSimpleButton(
                        text: "C", buttonBackgroundColor: Colors.redAccent),
                    buildSimpleButton(
                        text: "⌫", buttonBackgroundColor: Colors.redAccent),
                    buildSimpleButton(
                        text: "%", buttonBackgroundColor: Colors.redAccent),
                    buildSimpleButton(
                        text: "/", buttonBackgroundColor: Colors.redAccent),
                  ],
                ),
                TableRow(children: [
                  buildSimpleButton(
                      text: "7", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "8", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "9", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "-", buttonBackgroundColor: Colors.redAccent),
                ]),
                TableRow(children: [
                  buildSimpleButton(
                      text: "4", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "5", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "6", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "*", buttonBackgroundColor: Colors.redAccent),
                ]),
                TableRow(children: [
                  buildSimpleButton(
                      text: "1", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "2", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "3", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "+", buttonBackgroundColor: Colors.redAccent),
                ]),
                TableRow(children: [
                  buildSimpleButton(
                      text: "0", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: ".", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "π", buttonBackgroundColor: Colors.black54),
                  buildSimpleButton(
                      text: "=", buttonBackgroundColor: Colors.blueAccent),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
