import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.blueGrey[300]);
  final List<String> buttons = [
    '÷',
    '%',
    'C',
    '⌫',
    'x',
    '9',
    '8',
    '7',
    '-',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '=',
    '.',
    '00',
    '0'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //clear
                    if (index == 2) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    //delete
                    else if (index == 3) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    //equal
                    else if (index == 16) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            equalpressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(234, 254, 240, 75),
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueGrey
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.blueGrey,
                      );
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '÷' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalpressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
