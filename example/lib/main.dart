import 'package:flutter/material.dart';
import 'package:right/right.dart';

void main() {
  runApp(
    RApp(
      child: Navigator(
        onGenerateRoute: (settings) => RRoute(
          child: RScaffold(
            handleSafeArea: true,
            handleKeyBoard: true,
            backGroundColor: Colors.white,
            child: Column(
              children: [
                const RTextField(),
                Builder(builder: (context) {
                  return RButton(
                    child: const RText(text: "route"),
                    onPressed: () {
                      Navigator.of(context).push(
                        RRoute(
                          child: ColoredBox(
                            color: Colors.cyan,
                            child: Center(
                              child: RButton(
                                child:
                                    const RText(text: "Hello from new route"),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    RBottomSheetRoute(
                                      builder: (_) {
                                        return SingleChildScrollView(
                                          controller: _,
                                          child: Container(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
