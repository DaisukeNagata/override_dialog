import 'package:flutter/material.dart';
import 'package:override_dialog_example/drag_drop_my_app.dart';
import 'package:override_dialog_example/drawer_my_app.dart';
import 'package:override_dialog_example/front_and_my_app.dart';
import 'package:override_dialog_example/list_my_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: Builder(
            builder: (BuildContext context) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const DrawerMypp();
                          },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const DragDropMyApp();
                          },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FrontAndBackMyApp();
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: Center(
          child: ListMyApp(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ),
    );
  }
}
