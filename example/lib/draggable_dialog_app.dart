import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';

class DraggableDialogApp extends StatefulWidget {
  const DraggableDialogApp({super.key});

  @override
  State<DraggableDialogApp> createState() => _DraggableDialogAppState();
}

class _DraggableDialogAppState extends State<DraggableDialogApp> {
  final OverrideDialog dialog = OverrideDialog();
  bool _isFlg = false;
  int _counter = 0;

  @override
  void dispose() {
    super.dispose();
    dialog.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Dialog App'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _showDialog,
                      child: const Text('Sheet'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _counter += 1;
                        });
                      },
                      child: Text('Counter$_counter'),
                    ),
                  ],
                )
              ],
            ),
            if (_isFlg) ...[
              IgnorePointer(
                ignoring: true,
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    setState(() {
      _isFlg = !_isFlg;
    });
    dialog.show(
      context,
      const Offset(0, 0),
      _sheet(),
      300,
    );
  }

  Widget _sheet() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return NotificationListener<ScrollNotification>(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Material(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
