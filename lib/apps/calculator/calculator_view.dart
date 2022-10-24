import 'package:flutter/material.dart';
import 'calculator_model.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'calculator_view_model.dart';

T useChangeNotifierListenable<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class HomeView extends HookWidget {
  Widget _buildLayout({required CalculatorChangeNotifier homeChangeNotifier}) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.grey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${homeChangeNotifier.userInput}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${homeChangeNotifier.answer}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return CalcButton(
                    buttontapped: buttontapped(buttons[index].name, homeChangeNotifier),
                    buttonText: buttons[index].name,
                    backgroundColor: buttons[index].background,
                  );
                }), // GridView.builder
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var homeChangeNotifier = useChangeNotifierListenable(CalculatorChangeNotifier());

    Widget content;
    content = _buildLayout(homeChangeNotifier: homeChangeNotifier);

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: content,
    );
  }

  Function buttontapped(String str, CalculatorChangeNotifier homeChangeNotifier) {
    var userInput = homeChangeNotifier.userInput;
    var answer = homeChangeNotifier.answer;
    switch (str) {
      case 'C':
        return () {
          homeChangeNotifier.userInput = '';
          homeChangeNotifier.answer = '0';
          _operate(homeChangeNotifier);
        };
      case '%':
        return () {
          homeChangeNotifier.userInput += str;
          _operate(homeChangeNotifier);
        };
      case 'DEL':
        return () {
          homeChangeNotifier.userInput = userInput.substring(0, userInput.length - 1);
          _operate(homeChangeNotifier);
        };
      case '=':
        return () {
          equalPressed(homeChangeNotifier);
          _operate(homeChangeNotifier);
        };
      default: return  () {
        homeChangeNotifier.userInput += str;
        _operate(homeChangeNotifier);
      };
    }
  }

  void equalPressed(CalculatorChangeNotifier homeChangeNotifier) {
    String finaluserinput = homeChangeNotifier.userInput;
    finaluserinput = homeChangeNotifier.userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    homeChangeNotifier.answer = eval.toString();
  }

  Future<void> _operate(CalculatorChangeNotifier homeChangeNotifier) async {
    homeChangeNotifier.reloadState();
  }
}

class CalcButton extends HookWidget {

  // declaring variables
  final backgroundColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  CalcButton({this.backgroundColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: backgroundColor,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
        ),
      ),
    );
  }
}