import 'package:flutter/material.dart';
import 'package:r_ui_kit/src/r_button.dart';
import 'package:r_ui_kit/src/utils/keyboard_spacer.dart';
import 'package:r_ui_kit/src/utils/sizes.dart';

class RScaffold extends StatelessWidget {
  final Color? backGroundColor;
  final Color? iconsColor;
  final bool handleSafeArea;
  final VoidCallback? onLeadingTap, onTrailingTap;
  final Widget? title;
  final Widget? child, trailingWidget;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool handleKeyBoard;
  final bool showNavigationBar;
  final TextStyle? titleTextStyle;
  final int paddingAboveKeyboard;

  const RScaffold({
    Key? key,
    this.backGroundColor,
    this.onLeadingTap,
    this.title,
    this.child,
    this.trailingIcon,
    this.onTrailingTap,
    this.trailingWidget,
    this.handleSafeArea = true,
    this.leadingIcon,
    this.handleKeyBoard = false,
    this.iconsColor,
    this.showNavigationBar = true,
    this.titleTextStyle,
    this.paddingAboveKeyboard = 0,
  }) : super(key: key);

  static const appBarHeight = 54.0;
  static const iconButtonSize = 44.0;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: backGroundColor ?? Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showNavigationBar)
              Padding(
                padding: EdgeInsets.only(top: Sizes.effectiveTopPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15),
                    SizedBox.square(
                      dimension: iconButtonSize,
                      child: ModalRoute.of(context)!.canPop
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
              ),
            Expanded(child: child ?? nothing),
            if (handleKeyBoard)
              KeyboardSpacer(
                handleSafeArea: handleSafeArea,
                paddingAboveKeyboard: paddingAboveKeyboard,
              ),
            if(!handleKeyBoard && handleSafeArea)
              SizedBox(height: Sizes.effectiveBottomPadding)
          ],
        ),
      );
}
