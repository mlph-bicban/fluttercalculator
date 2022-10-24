import 'package:flutter/cupertino.dart';

class CalculatorChangeNotifier extends ChangeNotifier {
  var userInput = '';
  var answer = '0';

  Future<void> reloadState() async {
    notifyListeners();
  }
}