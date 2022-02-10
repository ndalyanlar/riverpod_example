import 'package:flutter/material.dart';

class AppColor {
  final Color appBarColor = const Color.fromARGB(255, 4, 19, 39);
  final Color scaffoldBackgroundColor = Color.fromARGB(255, 230, 220, 220);
  final Color closeFloatButtonColor = Colors.red;

  final Color noteBackgroundColor = const Color.fromARGB(255, 51, 55, 109);
  static late AppColor _instance;

  static AppColor get instance {
    _instance = AppColor._init();
    return _instance;
  }

  AppColor._init();
}
