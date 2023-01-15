import 'package:flutter/material.dart';
import 'package:r_ui_kit/src/bottom_sheet/r_bottom_sheet.dart';

final _key = GlobalKey<NavigatorState>();

class RBottomSheetWrapper extends InheritedWidget {
  final double borderRadius;
  RBottomSheetWrapper({
    Key? key,
    required Widget child,
    this.borderRadius = 24.0,
  }) : super(
          key: key,
          child: Navigator(
            key: _key,
            onGenerateRoute: (_) => RBottomSheetRoute(
              builder: (_) => child,
              root: true,
            ),
          ),
        );

  NavigatorState get navigator => _key.currentState!;

  @override
  bool updateShouldNotify(RBottomSheetWrapper oldWidget) {
    return false;
  }
}

extension RenesanseBottomSheetWrapperExtension on BuildContext {
  void showBottomSheet({
    required Widget Function(ScrollController controller) builder,
    required double openPercentage,
    Color backgroundColor = Colors.black,
  }) {
    final wrapper = dependOnInheritedWidgetOfExactType<RBottomSheetWrapper>()!;
    wrapper.navigator.push(
      RBottomSheetRoute(
        builder: builder,
        backgroundColor: backgroundColor,
        openPercentage: openPercentage,
        borderRadius: wrapper.borderRadius,
      ),
    );
  }
}
