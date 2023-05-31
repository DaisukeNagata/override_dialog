import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';
import 'package:override_dialog_example/global_key_ex.dart';

class ListMyApp extends StatefulWidget {
  const ListMyApp({
    Key? key,
    required this.bottom,
  }) : super(key: key);

  final double bottom;
  @override
  State<ListMyApp> createState() => _ListMyState();
}

class _ListMyState extends State<ListMyApp> {
  var y = 0.0;
  final _buttonHeight = 60.0;
  final offst = const Offset(0, 1);
  final List<FocusNode> _focusNode = [FocusNode()];
  final List<GlobalKey> _containerKey = [GlobalKey()];
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  final OverrideDialog _overlayDialog = OverrideDialog();
  _ListMyState();

  Stream<double> numberStream(int index) async* {
    while (y == 0.0) {
      await Future.delayed(const Duration(milliseconds: 400));
      final bottom = _containerKey[index].globalPaintBounds?.bottom ?? 0.0;

      if (bottom >
          // ignore: use_build_context_synchronously
          MediaQuery.of(context).size.height -
              (widget.bottom + _buttonHeight)) {
        _scrollController.jumpTo(
          _scrollController.offset + _buttonHeight,
        );
      }

      yield y = widget.bottom + _buttonHeight;
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _containerKey.clear();
    _focusNode.clear();
    for (var element in _focusNode) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (items.length != _containerKey.length) {
          _containerKey.add(GlobalKey());
          _focusNode.add(FocusNode());
        }
        return ListTile(
          title: Text(items[index]),
          subtitle: TextFormField(
            focusNode: _focusNode[index],
            key: _containerKey[index],
            onTap: () {
              if (Platform.isAndroid || Platform.isIOS) {
                _overlayDialog.show(
                  context,
                  offst,
                  StreamBuilder(
                    stream: numberStream(index),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Material(
                        child: Container(
                          color: Colors.black12,
                          height: y,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  y = 0;
                                  _overlayDialog.reset(context);
                                  _focusNode[index].unfocus();
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width,
                                  height: _buttonHeight,
                                  child: const Text('Close'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  500,
                );
              }
            },
            decoration: const InputDecoration(
              hintText: 'Enter your text here',
            ),
          ),
        );
      },
    );
  }
}
