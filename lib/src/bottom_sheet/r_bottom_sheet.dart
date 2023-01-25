import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:right/src/utils/sizes.dart';

class RBottomSheetRoute<T> extends PopupRoute<T> {
  final Widget Function(ScrollController controller) builder;
  final bool root;
  final double openPercentage;
  final Color backgroundColor;
  final double borderRadius;

  RBottomSheetRoute({
    required this.builder,
    this.root = false,
    this.openPercentage = 0.5,
    this.backgroundColor = Colors.blueAccent,
    this.borderRadius = 24,
  });

  var _ignoring = false;
  late final _innerSc = ScrollController();

  @override
  void dispose() {
    _innerSc.dispose();
    super.dispose();
  }

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  late final _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(borderRadius),
    topRight: Radius.circular(borderRadius),
  );

  void _onUpdate(DragUpdateDetails upd) {
    final initialValue = controller?.value ?? 1.0;
    final delta = upd.delta.dy;
    if (delta > 0 && _innerSc.offset <= 0) {
      _innerSc.jumpTo(0);
    }
    if (_innerSc.offset == 0) {
      controller?.value =
          initialValue - (upd.delta.dy / Sizes.screenSize.height);
    }
  }

  Future<void> _onEnd(DragEndDetails upd, VoidCallback onClose) async {
    final val = controller?.value ?? 0;
    final velocity = _innerSc.offset > 0 ? 0 : upd.primaryVelocity ?? 0;
    final toTop = val > openPercentage && velocity < 2000;
    setState(() {
      _ignoring = true;
    });
    await controller?.animateTo(
      toTop ? 1.0 : 0.0,
      duration: transitionDuration,
      curve: Curves.decelerate,
    );
    setState(() {
      _ignoring = false;
    });
    if (!toTop) {
      onClose();
    }
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    if (root) return builder(_innerSc);
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            _AllowMultipleGestureRecognizer>(
          () => _AllowMultipleGestureRecognizer(), //constructor
          (_AllowMultipleGestureRecognizer instance) {
            instance.onUpdate = _onUpdate;
            instance.onEnd = (upd) {
              _onEnd(
                upd,
                () => Navigator.of(context).pop(),
              );
            };
          },
        )
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: ColoredBox(
            color: backgroundColor,
            child: SizedBox(
              height: Sizes.screenSize.height * openPercentage,
              child: builder(_innerSc),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return DecoratedBoxTransition(
      position: DecorationPosition.background,
      decoration: animation.drive(
        DecorationTween(
          begin: BoxDecoration(color: Colors.transparent),
          end: BoxDecoration(color: Colors.black38),
        ),
      ),
      child: SlideTransition(
        transformHitTests: false,
        position: animation.drive(
          Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ),
        ),
        child: RepaintBoundary(
          child: IgnorePointer(
            ignoring: _ignoring,
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;
}

class _AllowMultipleGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
