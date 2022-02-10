import 'package:flutter/material.dart';

class MyTheme {
  InputDecoration myInputDecoration(
          {required String labelText,
          required String hintText,
          required Color borderColor,
          Icon? icon}) =>
      InputDecoration(
        contentPadding: const EdgeInsetsDirectional.all(10),
        icon: icon,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        hintText: hintText,
      );

  static late MyTheme _instance;

  static MyTheme get instance {
    _instance = MyTheme._init();
    return _instance;
  }

  MyTheme._init();
}
