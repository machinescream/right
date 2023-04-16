library right;

import 'package:flutter/material.dart';
import 'package:right/src/r_app.dart';
import 'package:right/src/r_bottom_sheet.dart';
import 'package:right/src/r_button.dart';
import 'package:right/src/r_list_tile.dart';
import 'package:right/src/r_route.dart';
import 'package:right/src/r_scaffold.dart';
import 'package:right/src/r_text.dart';
import 'package:right/src/r_user_tile.dart';

export 'package:right/src/utils/sizes.dart';
export 'package:right/src/utils/keyboard_spacer.dart';

abstract class Right implements Widget {
  const factory Right.app({Key? key, required Widget child}) = RApp;

  const factory Right.button({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry padding,
    Color? color,
    VoidCallback? onPressed,
    double? pressedOpacity,
    double? borderRadius,
    AlignmentGeometry alignment,
    BorderSide? border,
  }) = RButton;

  const factory Right.listTile({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
  }) = RListTile;

  const factory Right.scaffold({
    Key? key,
    Color backGroundColor,
    Color iconsColor,
    Color appBarColor,
    VoidCallback? onLeadingTap,
    VoidCallback? onTrailingTap,
    Widget? title,
    Widget? child,
    Widget? trailingWidget,
    IconData? leadingIcon,
    IconData? trailingIcon,
  }) = RScaffold;

  const factory Right.text({
    Key? key,
    required String text,
    TextStyle? style,
    double? textScaleFactor,
    TextOverflow? overflow,
    TextWidthBasis? textWidthBasis,
    int? maxLines,
  }) = RText;

  const factory Right.userTile({
    Key? key,
    String? imageUrl,
    required String userName,
    Color userAvatarBorderColor,
    TextStyle? textStyle,
    int avatarSize,
    EdgeInsets avatarPadding,
  }) = RUserTile;

  static RBottomSheetRoute bottomSheet({
    required BuilderWithScrollController builder,
    double openPercentage = 0.5,
    Color backgroundColor = Colors.white,
    double borderRadius = 24,
  }) =>
      RBottomSheetRoute(
        builder: builder,
        openPercentage: openPercentage,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
      );

  static RRoute route({required Widget child}) => RRoute(child: child);
}
