import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _displayText = '';
  double? _firstOperand;
  String? _operator;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _displayText = '';
        _firstOperand = null;
        _operator = null;
      } else if (value == '=') {
        _calculateResult();
      } else if ('+-*/'.contains(value)) {
        // Set the operator when an operator is pressed
        if (_displayText.isNotEmpty) {
          _firstOperand = double.tryParse(_displayText);
          _operator = value;
          _displayText +=
              value; // Keep the operator in the display for the next input
        }
      } else {
        _displayText += value; // Append number or operator
      }
    });
  }

  void _calculateResult() {
    if (_firstOperand != null && _operator != null) {
      String secondOperandText = _displayText.split(_operator!)[1];
      double secondOperand = double.tryParse(secondOperandText) ?? 0;

      double? result;
      switch (_operator) {
        case '+':
          result = _firstOperand! + secondOperand;
          break;
        case '-':
          result = _firstOperand! - secondOperand;
          break;
        case '*':
          result = _firstOperand! * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            _displayText = 'Error'; // Handle division by zero
            return;
          } else {
            result = _firstOperand! / secondOperand;
          }
          break;
      }
      _displayText = result.toString();
      _firstOperand = null; // Reset the operands and operator
      _operator = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(value),
      child: Text(value, style: TextStyle(fontSize: 24.0)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
