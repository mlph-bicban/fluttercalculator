import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CalculatorButtons {
  const CalculatorButtons({
    required this.name,
    required this.background,
  });

  final String name;
  // final String userInput;
  // final String answer;
  final Color background;
}

final List<CalculatorButtons> buttons = <CalculatorButtons>[
  CalculatorButtons(name: 'C', background: Colors.white),
  CalculatorButtons(name: '+/-', background: Colors.white),
  CalculatorButtons(name: '%', background: Colors.white),
  CalculatorButtons(name: 'DEL', background: Colors.white),
  CalculatorButtons(name: '7', background: Colors.white),
  CalculatorButtons(name: '8', background: Colors.white),
  CalculatorButtons(name: '9', background: Colors.white),
  CalculatorButtons(name: '/', background: Colors.blue),
  CalculatorButtons(name: '4', background: Colors.white),
  CalculatorButtons(name: '5', background: Colors.white),
  CalculatorButtons(name: '6', background: Colors.white),
  CalculatorButtons(name: 'x', background: Colors.blue),
  CalculatorButtons(name: '1', background: Colors.white),
  CalculatorButtons(name: '2', background: Colors.white),
  CalculatorButtons(name: '3', background: Colors.white),
  CalculatorButtons(name: '-', background: Colors.blue),
  CalculatorButtons(name: '0', background: Colors.white),
  CalculatorButtons(name: '.', background: Colors.white),
  CalculatorButtons(name: '=', background: Colors.blue),
  CalculatorButtons(name: '+', background: Colors.blue)
];