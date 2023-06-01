import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';

class DialogMyApp extends StatefulWidget {
  const DialogMyApp({Key? key}) : super(key: key);

  @override
  State<DialogMyApp> createState() => _DialogMyAppState();
}

class _DialogMyAppState extends State<DialogMyApp> {
  final OverrideDialog dialog = OverrideDialog();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DialogMyApp'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                dialog.hide(context, 100);
              },
              child: const Text('Backround'),
            ),
            TextButton(
              child: const Text('TextButton'),
              onPressed: () {
                dialog.show(
                  context,
                  const Offset(0, 1),
                  Stack(
                    children: [
                      IgnorePointer(
                        ignoring: true,
                        child: Container(
                          color: Colors.black54,
                        ),
                      ),
                      AlertDialog(
                        title: const Text('Alert Dialog'),
                        content: const Text('This is a simple alert dialog.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              dialog.hide(context, 100);
                            },
                            child: const Text('Close'),
                          )
                        ],
                      ),
                    ],
                  ),
                  10,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
