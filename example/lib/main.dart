import 'package:flutter/material.dart';
import 'package:right/right.dart';

Future<void> main() async {
  await Future.delayed(Duration(seconds: 1));
  runApp(
    RApp(
      child: Navigator(
        onGenerateRoute: (_) {
          return RRoute(
              child: RScaffold(
            key: const ValueKey("main"),
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
                Builder(
                  builder: (context) {
                    return RButton(
                      child: const Text('route'),
                      onPressed: () {
                        Navigator.of(context).push(
                          RRoute(
                            child: RScaffold(
                              backGroundColor: Colors.black.withOpacity(0.1),
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
                  },
                ),
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Sizes.screenPadding.bottom),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blueAccent,
                        child: const TextField(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ));
        },
      ),
    ),
  );
}
