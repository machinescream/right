import 'package:flutter/material.dart';
import 'package:right/src/r_route.dart';

class RNavigator extends StatefulWidget {
  final Widget child;
  const RNavigator({super.key, required this.child});

  @override
  State<RNavigator> createState() => RNavigatorState();
}

class RNavigatorState extends State<RNavigator> {
  late final widgets = [widget.child];

  @override
  Widget build(BuildContext context) {
    return Stack(children: widgets);
  }

  void add(Widget widget) {
    setState(() {
      widgets.add(RRoute(child: widget));
    });
  }

  void removeLast() {
    setState(() {
      widgets.removeLast();
    });
  }
}
