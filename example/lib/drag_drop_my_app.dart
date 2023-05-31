import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

class DragDropMyApp extends StatefulWidget {
  const DragDropMyApp({Key? key}) : super(key: key);

  @override
  State<DragDropMyApp> createState() => _DragDropState();
}

class _DragDropState extends State<DragDropMyApp> {
  final OverlayDialog _overRayDialog = OverlayDialog();
  StreamController _streamController = StreamController.broadcast();
  String _tex = 'drag&drop';
  final _offst = const Offset(0, 1);
  final String _dataSet = 'backborn';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Draggable(
              data: _dataSet,
              feedback: Material(
                child: Text(_dataSet),
              ),
              childWhenDragging: Text(_dataSet),
              child: Text(_dataSet),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_streamController.hasListener) {
                  _streamController.close();
                  _streamController = StreamController.broadcast();
                }
                _overRayDialog.show(
                  context,
                  _offst,
                  Container(
                      height: MediaQuery.of(context).size.height / 2,

                      // set size
                      color: Colors.blue,

                      // set color
                      child: Container(
                          alignment: Alignment.center,
                          child: StreamBuilder(
                            stream: _streamController.stream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Material(
                                child: DragTarget(
                                  onAccept: (data) {
                                    setState(() {
                                      _tex = data.toString();
                                    });
                                  },
                                  builder: (BuildContext context,
                                      List<Object?> candidateData,
                                      List<dynamic> rejectedData) {
                                    return Text(
                                      _tex,
                                      style: const TextStyle(fontSize: 24),
                                    );
                                  },
                                ),
                              );
                            },
                          ))),
                  200, // set speed
                );
              },
              child: const Text('Show Overlay'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _tex = 'drag&drop';
                });
                _streamController.sink.add(0);
              },
              child: const Text('Clear Data'),
            ),
          ],
        ),
      ),
    );
  }
}
