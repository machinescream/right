import 'dart:ui';
import 'package:flutter/widgets.dart';

abstract class Sizes {
  static Size get screenSize {
    return window.physicalSize / window.devicePixelRatio;
  }

  static EdgeInsets get screenPadding {
    return EdgeInsets.fromWindowPadding(window.padding, window.devicePixelRatio);
  }
}

const nothing = SizedBox.shrink();
