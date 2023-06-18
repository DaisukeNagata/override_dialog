import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';

class CircleProgress extends StatefulWidget {
  const CircleProgress({Key? key}) : super(key: key);
  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress> {
  @override
  Widget build(BuildContext context) {
    final OverrideDialog dialog = OverrideDialog();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CircleProgress'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            dialog.show(
              context,
              const Offset(0, 1),
              const Center(
                child: CircularProgressIndicator(),
              ),
              10,
            );
          },
          child: const Text('button'),
        ),
      ),
    );
  }
}
