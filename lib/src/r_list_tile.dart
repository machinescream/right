import 'package:flutter/cupertino.dart';

class RListTile extends StatefulWidget {
  const RListTile({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  State<RListTile> createState() => _RListTileState();
}

class _RListTileState extends State<RListTile> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 0.0);

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
  void didUpdateWidget(RListTile old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = 1.0;
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
    if (_animationController.isAnimating) return;
    final wasHeldDown = _buttonHeldDown;
    (_buttonHeldDown
            ? _animationController.animateTo(
                1.0,
                duration: kFadeOutDuration,
                curve: Curves.easeInOutCubicEmphasized,
              )
            : _animationController.animateTo(
                0.0,
                duration: kFadeInDuration,
                curve: Curves.easeOutCubic,
              ))
        .then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,
      child: Stack(
        children: [
          ScaleTransition(
            scale: _opacityAnimation.drive(Tween(begin: 1.0, end: 0.9)),
            child: widget.child,
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: const ColoredBox(
                color: CupertinoColors.systemFill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
