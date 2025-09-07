
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operator = "";

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operator = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      num1 = double.parse(output);
      operator = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operator == "+") {
        _output = (num1 + num2).toString();
      }
      if (operator == "-") {
        _output = (num1 - num2).toString();
      }
      if (operator == "*") {
        _output = (num1 * num2).toString();
      }
      if (operator == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operator = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      double value = double.parse(_output);
      output = value == value.roundToDouble()
          ? value.toStringAsFixed(0)
          : value.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            alignment: Alignment.topRight,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),

          Divider(color: Colors.grey[900]),
          SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Row(
                  spacing: 3,
                  children: [
                    buildButton("7", Colors.black54),
                    buildButton("8", Colors.black54),
                    buildButton("9", Colors.black54),
                    buildButton("/", Colors.orange),
                  ],
                ),
                Row(
                  spacing: 3,
                  children: [
                    buildButton("4", Colors.black54),
                    buildButton("5", Colors.black54),
                    buildButton("6", Colors.black54),
                    buildButton("*", Colors.orange),
                  ],
                ),
                Row(
                  spacing: 3,
                  children: [
                    buildButton("1", Colors.black54),
                    buildButton("2", Colors.black54),
                    buildButton("3", Colors.black54),
                    buildButton("-", Colors.orange),
                  ],
                ),
                Row(
                  spacing: 3,
                  children: [
                    buildButton("0", Colors.black54),
                    buildButton(".", Colors.black54),
                    buildButton("AC", Colors.red),
                    buildButton("+", Colors.orange),
                  ],
                ),
                Row(children: [buildButton("=", Colors.green)]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
