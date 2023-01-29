import 'package:flutter/material.dart';

class RApp extends StatelessWidget {
  final Widget child;
  const RApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: MediaQuery.fromWindow(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [OverlayEntry(builder: (context) => child)],
          ),
        ),
      ),
    );
  }
}
