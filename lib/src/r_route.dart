import 'package:flutter/material.dart';
import 'package:right/src/r_navigator.dart';
import 'package:right/src/utils/sizes.dart';

class RRoute<T> extends StatefulWidget {
  final Widget child;

  const RRoute({super.key, required this.child});

  @override
  State<RRoute<T>> createState() => _RRouteState<T>();
}

class _RRouteState<T> extends State<RRoute<T>> with TickerProviderStateMixin {
  var _ignoring = false;
  final _maxWidth = Sizes.screenSize.width;

  late final controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: _maxWidth,
  );

  void _onHorizontalDragEnd(DragEndDetails upd, VoidCallback onClose) {
    final val = controller.value;
    final toLeft = val > 0.5 && upd.primaryVelocity! < 1000;
    setState(() {
      _ignoring = true;
    });
    controller.animateTo(toLeft ? _maxWidth : 0.0).then((value) {
      setState(() {
        _ignoring = false;
      });
      if (!toLeft) {
        onClose();
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails upd) {
    final initialValue = controller.value;
    controller.value = initialValue - upd.delta.dx;
  }

  @override
  void initState() {
    super.initState();
    controller.animateTo(_maxWidth);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (_, child) {
        return Transform.translate(
          transformHitTests: false,
          offset: Offset(
            Sizes.screenSize.width - controller.value,
            0,
          ),
          child: IgnorePointer(
            ignoring: _ignoring,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragEnd: (upd) {
                _onHorizontalDragEnd(
                  upd,
                  () => context
                      .findAncestorStateOfType<RNavigatorState>()!
                      .removeLast(),
                );
              },
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
