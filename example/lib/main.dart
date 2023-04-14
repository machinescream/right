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
            appBarColor: Colors.blue,
            title: const RText(
              text: 'Demo',
              style: TextStyle(color: Colors.white),
            ),
            child: Column(
              children: [
                Expanded(child: Center(
                  child: Builder(builder: (context) {
                    return RButton(
                      child: const Text('bottom_sheet'),
                      onPressed: () {
                        Navigator.of(context).push(
                          RBottomSheetRoute(
                            backgroundColor: Colors.black,
                            builder: (controller) {
                              return ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return RListTile(
                                    child: RUserTile(
                                      avatarSize: 34,
                                      avatarPadding: const EdgeInsets.all(8),
                                      userName: "User $index",
                                      imageUrl: "https://picsum.photos/200/300",
                                      userAvatarBorderColor: Colors.blue,
                                      titleTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () {},
                                  );
                                },
                                itemCount: 100,
                                controller: controller,
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
                              child: Container(
                                height: 800,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          color: Colors.green,
                                          child: const Center(
                                            child: Text('13'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextField(),
                                  ],
                                ),
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
                      padding:
                          EdgeInsets.only(bottom: Sizes.screenPadding.bottom),
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
