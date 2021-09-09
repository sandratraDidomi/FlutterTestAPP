import 'package:flutter/material.dart';

abstract class ThemeBuilder{
  static double _dividerThickness = 0.3;
  static Divider getDivider(){
    return Divider(color: Colors.green, thickness: _dividerThickness);
  }
}