import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:right/src/r_button.dart';
import 'package:right/src/utils/keyboard_spacer.dart';
import 'package:right/src/utils/sizes.dart';

class RScaffold extends StatelessWidget {
  final Color backGroundColor, iconsColor;
  final VoidCallback? onLeadingTap, onTrailingTap;
  final Widget? title, child, trailingWidget;
  final IconData? leadingIcon, trailingIcon;

  const RScaffold({
    super.key,
    this.backGroundColor = Colors.white,
    this.iconsColor = Colors.white,
    this.onLeadingTap,
    this.title,
    this.child,
    this.trailingIcon,
    this.onTrailingTap,
    this.trailingWidget,
    this.leadingIcon,
  });

  static const appBarHeight = 54.0;
  static const iconButtonSize = 44.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backGroundColor,
      child: RawGestureDetector(
        behavior: HitTestBehavior.opaque,
        gestures: {
          _AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<_AllowMultipleGestureRecognizer>(
            () => _AllowMultipleGestureRecognizer(), //constructor
            (_AllowMultipleGestureRecognizer instance) {
              instance.onDown = (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              };
            },
          )
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RNavigationBar(
              iconButtonSize: RScaffold.iconButtonSize,
              iconsColor: iconsColor,
              onLeadingTap: onLeadingTap,
              title: title,
              trailingIcon: trailingIcon,
              trailingWidget: trailingWidget,
              onTrailingTap: onTrailingTap,
            ),
            Expanded(child: child ?? nothing),
            const KeyboardSpacer(),
          ],
        ),
      ),
    );
  }
}

class RNavigationBar extends StatelessWidget {
  const RNavigationBar({
    super.key,
    required this.iconButtonSize,
    required this.iconsColor,
    required this.onLeadingTap,
    required this.title,
    required this.trailingIcon,
    required this.trailingWidget,
    required this.onTrailingTap,
  });

  final double iconButtonSize;
  final Color? iconsColor;
  final VoidCallback? onLeadingTap;
  final Widget? title;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.screenPadding.top),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 15),
          SizedBox.square(
            dimension: iconButtonSize,
            child: (ModalRoute.of(context)!.canPop)
                ? RButton(
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 24,
                      color: iconsColor ?? Colors.black,
                    ),
                    onPressed: () {
                      if (onLeadingTap == null) {
                        Navigator.of(context).pop();
                      } else {
                        onLeadingTap!();
                      }
                    },
                  )
                : nothing,
          ),
          Expanded(
            child: title != null ? Center(child: title!) : nothing,
          ),
          SizedBox.square(
            dimension: iconButtonSize,
            child: trailingIcon != null || trailingWidget != null
                ? RButton(
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () => onTrailingTap?.call(),
                    child: trailingIcon != null
                        ? Icon(
                            trailingIcon,
                            size: 24,
                            color: iconsColor ?? Colors.black,
                          )
                        : trailingWidget!,
                  )
                : nothing,
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class _AllowMultipleGestureRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
