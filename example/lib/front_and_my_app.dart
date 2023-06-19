import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';

class FrontAndBackMyApp extends StatefulWidget {
  const FrontAndBackMyApp({Key? key}) : super(key: key);

  @override
  State<FrontAndBackMyApp> createState() => _FrontAndBackState();
}

class _FrontAndBackState extends State<FrontAndBackMyApp> {
  final OverrideDialog dialog = OverrideDialog();
  final OverrideDialog dialog2 = OverrideDialog();

  @override
  void dispose() {
    if (!dialog.isOpen) {
      dialog.hide(context);
    }
    if (!dialog2.isOpen) {
      dialog2.hide(context);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FrontAndBackMyApp'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                if (dialog.isOpen) {
                  _dialog(
                    dialog,
                    'dialog',
                    Colors.blue.withOpacity(0.5),
                    const Size(300, 300),
                    const EdgeInsets.only(right: 100),
                  );
                } else {
                  dialog.reset(context);
                  _dialog(
                    dialog,
                    'dialog',
                    Colors.blue.withOpacity(0.5),
                    const Size(300, 300),
                    const EdgeInsets.only(right: 100),
                  );
                }
              },
              child: const Text('button'),
            ),
            TextButton(
              onPressed: () {
                if (dialog2.isOpen) {
                  _dialog(
                    dialog2,
                    'dialog2',
                    Colors.red.withOpacity(0.5),
                    const Size(300, 300),
                    const EdgeInsets.only(left: 100),
                  );
                } else {
                  dialog2.reset(context);
                  _dialog(
                    dialog2,
                    'dialog2',
                    Colors.red.withOpacity(0.5),
                    const Size(300, 300),
                    const EdgeInsets.only(left: 100),
                  );
                }
              },
              child: const Text('button'),
            ),
          ],
        ),
      ),
    );
  }

  _dialog(
    OverrideDialog dialog,
    String tex,
    Color color,
    Size size,
    EdgeInsets edgeInsets,
  ) {
    dialog.show(
      context,
      const Offset(0, 1),
      IgnorePointer(
        ignoring: true,
        child: Container(
          padding: edgeInsets,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            color: color,
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tex),
                ],
              ),
            ),
          ),
        ),
      ),
      1,
    );
  }
}
