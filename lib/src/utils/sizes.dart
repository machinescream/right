import 'dart:ui';
import 'package:flutter/widgets.dart';

abstract class Sizes {
  static Size get screenSize {
    final size = window.physicalSize / window.devicePixelRatio;
    return size == Size.zero ? screenSize : size;
  }

  static EdgeInsets get screenPadding {
    final padding = EdgeInsets.fromWindowPadding(window.padding, window.devicePixelRatio);
    return padding == EdgeInsets.zero ? screenPadding : padding;
  }
}

const nothing = SizedBox.shrink();
