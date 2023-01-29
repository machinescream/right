import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:right/right.dart';

void main() {
  runApp(
    RApp(
      child: RNavigator(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 124),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoTextField(),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                return RButton(
                  child: const RText(text: "route"),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // SystemChannels.textInput.invokeMethod('TextInput.hide');
                    context
                        .findAncestorStateOfType<RNavigatorState>()!
                        .add(ColoredBox(
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
                        ));
                  },
                );
              }),
              const SizedBox(height: 8),
              RListTile(
                child: const RText(text: "list tile"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
