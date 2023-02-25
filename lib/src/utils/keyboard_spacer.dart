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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = ModalRoute.of(context)!.isCurrent ? MediaQuery.of(context).viewInsets.bottom : 0.0;
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
