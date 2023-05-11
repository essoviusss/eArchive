import 'package:flutter/material.dart';

class ScreenUtil {
  static double get heightVar =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double get widthVar =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}
