import 'package:flutter/material.dart';
import 'package:right/right.dart';

Future<void> main() async {
  await Future.delayed(Duration(seconds: 1));
  runApp(
    Right.app(
      child: Navigator(
        onGenerateRoute: (_) {
          return Right.route(
              child: Right.scaffold(
            appBarColor: Colors.blue,
            title: const Right.text(
              text: 'Demo',
              style: TextStyle(color: Colors.white),
            ),
            child: Column(
              children: [
                Expanded(child: Center(
                  child: Builder(builder: (context) {
                    return Right.button(
                      child: const Text('bottom_sheet'),
                      onPressed: () {
                        Navigator.of(context).push(
                          Right.bottomSheet(
                            backgroundColor: Colors.black,
                            builder: (controller) {
                              return ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return Right.listTile(
                                    child: Right.userTile(
                                      avatarSize: 34,
                                      avatarPadding: const EdgeInsets.all(8),
                                      userName: "User $index",
                                      imageUrl: "https://picsum.photos/200/300",
                                      userAvatarBorderColor: Colors.blue,
                                      textStyle: const TextStyle(
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
                    return Right.button(
                      child: const Text('route'),
                      onPressed: () {
                        Navigator.of(context).push(
                          Right.route(
                            child: Right.scaffold(
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
