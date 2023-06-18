import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';

class CircleProgress extends StatefulWidget {
  const CircleProgress({Key? key}) : super(key: key);
  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Future<String> createFuture() async {
      await Future.delayed(const Duration(seconds: 2));
      return 'Hello, World!';
    }

    final OverrideDialog dialog = OverrideDialog();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loading Widget Example'),
        ),
        body: FutureBuilder<String>(
          future: createFuture(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Center(
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
            );
          },
        ),
      ),
    );
  }
}
