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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mr.secondaryAnimation!.addListener(_animationListener);
    });
  }

  void _animationListener() {
    if (_mr.secondaryAnimation!.value == 1.0) {
      _canAnimate = false;
    }
  }

  @override
  void dispose() {
    _mr.secondaryAnimation!.removeListener(_animationListener);
    _controller.dispose();
    super.dispose();
  }

  bool _canAnimate = false;

  @override
  Widget build(BuildContext context) {
    var value = MediaQuery.of(context).viewInsets.bottom;
    if (!_canAnimate) {
      _canAnimate = value == 0.0 && _mr.isCurrent;
    }
    value = _canAnimate ? value : 0.0;
    return AnimatedBuilder(
      animation: _controller..value = value,
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
