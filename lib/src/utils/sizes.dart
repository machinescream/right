import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class Sizes {
  static final screenSize = window.physicalSize / window.devicePixelRatio;
  static final EdgeInsets screenPadding =
      EdgeInsets.fromWindowPadding(window.padding, window.devicePixelRatio);

  static final double effectiveTopPadding =
      screenPadding.top + ((screenPadding.top == 0 || Platform.isAndroid) ? 12 : 0);

  static final double effectiveBottomPadding =
      screenPadding.bottom + ((screenPadding.bottom == 0 || Platform.isAndroid) ? 12 : 0);
}

const nothing = SizedBox.shrink();
