import 'package:flutter/material.dart';
import 'package:overlay_dialog/override_dialog.dart';

class DrawerMypp extends StatefulWidget {
  const DrawerMypp({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMypp> createState() => _DrawerMyppState();
}

class _DrawerMyppState extends State<DrawerMypp> {
  final _buttonHeight = 200.0;
  final _offst = const Offset(1, 0);
  final _innerOffst = const Offset(0, 1);
  final Color _color = Colors.amber.shade100;
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  final OverrideDialog _overRayDialog = OverrideDialog();
  final OverrideDialog _overRayDialog2 = OverrideDialog();
  _DrawerMyppState();

  @override
  void dispose() {
    if (!_overRayDialog.isOpen) {
      _overRayDialog.hide(context, 10);
    }
    if (!_overRayDialog2.isOpen) {
      _overRayDialog2.hide(context, 10);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DrawerMyApp"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: TextButton(
              onPressed: () {
                if (_overRayDialog.isOpen) {
                  _backGroundColor();
                } else {
                  _overRayDialog.reset(context);
                }
              },
              child: const Text(
                'button',
                textAlign: TextAlign.left,
              ),
            ),
          );
        },
      ),
    );
  }

  _backGroundColor() {
    _overRayDialog.show(
      context,
      _offst,
      IgnorePointer(
        ignoring: false,
        child: Container(
          transform: Matrix4.translationValues(_buttonHeight, 0, 0),
          color: _color,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Material(
                child: ListTile(
                  tileColor: _color,
                  title: Material(
                    color: Colors.transparent,
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (_overRayDialog2.isOpen) {
                      _innerBackground(index);
                    } else {
                      _overRayDialog2.reset(context);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
      100,
    );
  }

  _innerBackground(int index) {
    _overRayDialog2.show(
      context,
      _innerOffst,
      IgnorePointer(
        ignoring: true,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
            ),
            child: const Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alert Dialog'),
                ],
              ),
            ),
          ),
        ),
      ),
      10,
    );
  }
}
