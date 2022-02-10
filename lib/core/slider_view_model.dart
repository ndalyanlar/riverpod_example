import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {
  double _value = 0;

  double get value => _value;

  void increaseSlider(double value) {
    _value = value;
    notifyListeners();
  }
}
