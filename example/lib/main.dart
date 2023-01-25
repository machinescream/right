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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RTextField(
                    hint: "example",
                    padding: EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 8),
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
                                  child: const RText(text: "open bottom sheet"),
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
                  const SizedBox(height: 8),
                  RListTile(child: const RText(text: "list tile"), onPressed: (){}),


                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
