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

class _KeyboardSpacerState extends State<KeyboardSpacer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration.zero,
    lowerBound: 0,
    upperBound: Sizes.screenSize.height,
  );

  late final _mr = ModalRoute.of(context)!;
  late final _routeAnimation = _mr.secondaryAnimation!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _routeAnimation.addListener(_checkRoute);
      }
    });
  }

  bool _canAnimate = true;

  void _checkRoute() {
    if (_routeAnimation.value == 1.0) {
      setState(() {
        _canAnimate = false;
      });
    }
    if (_routeAnimation.value == 0.0) {
      setState(() {
        _canAnimate = true;
      });
    }
  }

  @override
  void dispose() {
    _routeAnimation.removeListener(_checkRoute);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_canAnimate) return nothing;
    return AnimatedBuilder(
      animation: _controller..value = MediaQuery.of(context).viewInsets.bottom,
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
