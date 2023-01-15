import 'dart:ui';
import 'package:flutter/cupertino.dart';

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

class _KeyboardSpacerState extends State<KeyboardSpacer> {
  final _vn = ValueNotifier(0);

  @override
  void dispose() {
    _vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Builder(builder: (ctx) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (mounted) {
              _vn.value = MediaQuery.of(ctx).viewInsets.bottom.toInt();
            }
          });
          return const SizedBox.shrink();
        }),
        ValueListenableBuilder(
          valueListenable: _vn,
          builder: (context, height, _) {
            if(height > 100){
              height += widget.paddingAboveKeyboard;
            }
            if(height < 100 && widget.handleSafeArea){
              height += window.padding.bottom ~/ window.devicePixelRatio;
            }
            return SizedBox(height: height.toDouble());
          },
        ),
      ],
    );
  }
}
