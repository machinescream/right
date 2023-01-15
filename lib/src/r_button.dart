import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class RButton extends StatefulWidget {
  const RButton({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.color = Colors.blue,
    this.pressedOpacity = 0.4,
    this.borderRadius = 8,
    this.alignment = Alignment.center,
    this.onPressed,
    this.border,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onPressed;
  final double? pressedOpacity;
  final double? borderRadius;
  final AlignmentGeometry alignment;
  final BorderSide? border;

  @override
  State<RButton> createState() => _RButtonState();
}

class _RButtonState extends State<RButton> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation =
        _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(RButton old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacity ?? 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0,
            duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onPressed != null;
    final Color? backgroundColor = widget.color;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: ShapeDecoration(
            color: backgroundColor != null && !enabled
                ? backgroundColor.withOpacity(0.4)
                : backgroundColor,
            shape: SuperellipseShape(
              side: widget.border ?? BorderSide.none,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
            ),
          ),
          child: Padding(
            padding: widget.padding,
            child: Align(
              alignment: Alignment.center,
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
