import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:right/right.dart';

class RApp extends StatelessWidget implements Right {
  final Widget child;
  const RApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      child: MediaQuery.fromView(
        view: WidgetsBinding.instance.window,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) => Material(child: child))
            ],
          ),
        ),
      ),
    );
  }
}
