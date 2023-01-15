import 'package:flutter/material.dart';

class BrightnessHandler extends StatefulWidget {
  final Widget child;
  const BrightnessHandler({Key? key, required this.child}) : super(key: key);

  @override
  State<BrightnessHandler> createState() => _BrightnessHandlerState();
}

class _BrightnessHandlerState extends State<BrightnessHandler> {
  final _vn = ValueNotifier(Brightness.dark);

  @override
  void dispose() {
    _vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Builder(
          builder: (ctx) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _vn.value = MediaQuery.of(ctx).platformBrightness;
            });
            return const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder(
          valueListenable: _vn,
          builder: (_, value, __) {
            return _BrightnessHandler(
              brightness: value,
              child: widget.child,
            );
          },
        )
      ],
    );
  }
}

class _BrightnessHandler extends InheritedWidget {
  final Brightness brightness;

  const _BrightnessHandler({
    Key? key,
    required this.brightness,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static _BrightnessHandler of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BrightnessHandler>()!;
  }

  @override
  bool updateShouldNotify(_BrightnessHandler oldWidget) {
    return oldWidget.brightness != brightness;
  }
}

extension BrightnessExtension on BuildContext {
  bool get dark {
    return _BrightnessHandler.of(this).brightness == Brightness.dark;
  }
}
