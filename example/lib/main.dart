import 'package:flutter/material.dart';

void main() {
  runApp(Navigator(
    onGenerateRoute: (settings) => RRoute(
      child: RScaffold(
        handleSafeArea: true,
        handleKeyBoard: true,
        backGroundColor: Colors.purple,
        child: Column(
          children: [
            RTextField(),
            RButton(child: RText())
          ],
        ),
      ),
    ),
  ));
}



