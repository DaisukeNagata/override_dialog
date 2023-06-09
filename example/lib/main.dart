import 'package:flutter/material.dart';
import 'package:override_dialog_example/circular_progress.dart';
import 'package:override_dialog_example/dialog_my_app.dart';
import 'package:override_dialog_example/drag_drop_my_app.dart';
import 'package:override_dialog_example/draggable_dialog_app.dart';
import 'package:override_dialog_example/drawer_my_app.dart';
import 'package:override_dialog_example/front_and_my_app.dart';
import 'package:override_dialog_example/list_my_app.dart';
import 'package:override_dialog_example/picker_my_app.dart';

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
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: [
                        _iconWidget(const DrawerMypp(), context),
                        _iconWidget(const DragDropMyApp(), context),
                        _iconWidget(const FrontAndBackMyApp(), context),
                        _iconWidget(const DialogMyApp(), context),
                        _iconWidget(const CircleProgress(), context),
                        _iconWidget(const PickerMyApp(), context),
                        _iconWidget(const DraggableDialogApp(), context),
                      ],
                    ),
                  ],
                ),
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

  Widget _iconWidget(Widget w, BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return w;
            },
          ),
        );
      },
    );
  }
}
