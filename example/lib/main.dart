import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:right/right.dart';

final avn = ValueNotifier(Offset.zero);
final vn = ValueNotifier(Offset.zero);
void main() {
  runApp(
    RApp(
      child: Navigator(
        onGenerateRoute: (_) {
          return RRoute(
              child: RScaffold(
            child: Column(
              children: [
                Expanded(child: Center(
                  child: Builder(builder: (context) {
                    return RButton(
                      child: const Text('bottom_sheet'),
                      onPressed: () {
                        Navigator.of(context).push(
                          RBottomSheetRoute(
                            builder: (c) {
                              return SingleChildScrollView(
                                controller: c,
                                child: Container(
                                  height: 500,
                                  color: Colors.amber,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
                )),
                Builder(builder: (context) {
                  return RButton(
                    child: const Text('route'),
                    onPressed: () {
                      Navigator.of(context).push(
                        RRoute(
                          child: RScaffold(
                            child: Container(
                              height: 500,
                              color: Colors.amber.withOpacity(0.1),
                              child: const TextField(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
                Builder(builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Sizes.screenPadding.bottom),
                    child: Container(
                      child: TextField(),
                      padding: EdgeInsets.all(8),
                      color: Colors.blueAccent,
                    ),
                  );
                }),
              ],
            ),
          ));
        },
      ),
    ),
  );
}
