import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:right/right.dart';

class KeyboardSpacer extends StatefulWidget {
  final bool handleSafeArea;
  final int paddingAboveKeyboard;

  const KeyboardSpacer({
    Key? key,
    this.handleSafeArea = false,
    this.paddingAboveKeyboard = 0,
  }) : super(key: key);

  @override
  State<KeyboardSpacer> createState() => _KeyboardSpacerState();
}

class _KeyboardSpacerState extends State<KeyboardSpacer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration.zero,
    lowerBound: 0,
    upperBound: Sizes.screenSize.height,
  );

  late final _mr = ModalRoute.of(context)!;

  void _checkRoute() {
    if (_mr.secondaryAnimation!.value == 1.0) {
      _canAnimate = false;
    }
    if (_mr.secondaryAnimation!.value == 0.0 && _mr.isCurrent && value == 0.0) {
      _canAnimate = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _canAnimate = true;
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    value = MediaQuery.of(context).viewInsets.bottom;
    _checkRoute();
    return AnimatedBuilder(
      animation: _controller..value = _canAnimate ? value : 0.0,
      builder: (context, child) {
        var height = _controller.value;
        if (height > 100) {
          height += widget.paddingAboveKeyboard;
        }
        if (height < 100 && widget.handleSafeArea) {
          height += Sizes.screenPadding.bottom;
        }
        return SizedBox(height: height);
      },
    );
  }
}
