import 'package:flutter/material.dart';
import 'package:right/src/utils/sizes.dart';

class RRoute<T> extends PageRoute<T> {
  final Widget child;

  RRoute({required this.child});

  var _ignoring = false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  void _onHorizontalDragEnd(DragEndDetails upd, VoidCallback onClose) {
    setState(() {
      _ignoring = true;
    });
    final val = controller!.value;
    final toLeft = val > 0.5 && upd.primaryVelocity! < 1000;
    controller!.animateTo(toLeft ? 1.0 : 0.0).then((value) {
      setState(() {
        _ignoring = false;
      });
      if (!toLeft) {
        onClose();
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails upd) {
    final initialValue = controller?.value ?? 1.0;
    controller?.value = initialValue - (upd.delta.dx / Sizes.screenSize.width);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final navigator = Navigator.of(context);
    return SlideTransition(
      transformHitTests: false,
      position: animation.drive(
        Tween(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: RepaintBoundary(
        child: SlideTransition(
          transformHitTests: false,
          position: secondaryAnimation.drive(
            Tween(
              begin: const Offset(0, 0),
              end: const Offset(-0.33, 0),
            ),
          ),
          child: RepaintBoundary(
            child: DecoratedBoxTransition(
              position: DecorationPosition.foreground,
              decoration: secondaryAnimation.drive(
                DecorationTween(
                  begin: BoxDecoration(color: Colors.transparent),
                  end: BoxDecoration(color: Colors.black87),
                ),
              ),
              child: navigator.canPop()
                  ? IgnorePointer(
                      ignoring: _ignoring,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragEnd: (upd) {
                          _onHorizontalDragEnd(upd, () => navigator.pop());
                        },
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        child: child,
                      ),
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
