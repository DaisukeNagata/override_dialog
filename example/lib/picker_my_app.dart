import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:override_dialog/override_dialog.dart';
import 'package:override_dialog_example/custom_24_picker.dart';

class PickerMyApp extends StatefulWidget {
  const PickerMyApp({super.key});

  @override
  State<PickerMyApp> createState() => _ChoicePickState();
}

class _ChoicePickState extends State<PickerMyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChoicePickMyApp'),
      ),
      body: const Center(
        child: BirthdayPicker(),
      ),
    );
  }
}

class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({super.key});

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  final OverrideDialog dialog = OverrideDialog();
  var bornList = [
    ['1990', '01', '01', '01'],
    ['1990', '01', '01', '01'],
    ['1990', '01', '01', '01']
  ];

  @override
  void dispose() {
    super.dispose();
    dialog.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bornList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => _timePicker(context, index),
            child: Text(
              '${bornList[index].first}/${bornList[index][1]}/${bornList[index][2]}/${bornList[index].last}',
            ),
          ),
        );
      },
    );
  }

  Future<void> _timePicker(
    BuildContext context,
    int index,
  ) async {
    if (dialog.isOpen) {
      await _dialogWidget(index);
    } else {
      await dialog.upDate(
        context,
        _picker(index),
        const Offset(0, 1),
      );
    }
  }

  _dialogWidget(int index) async {
    await dialog.show(
      context,
      const Offset(0, 1),
      _picker(index),
      300,
    );
  }

  Widget _myPageBottomPicker(Widget picker) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          picker,
        ],
      ),
    );
  }

  List<Widget> listYear(
    int start,
    int index,
  ) {
    return List<Widget>.generate(
      index - start,
      (int index) {
        return Center(
          child: Text(
            (++index + start).toString(),
          ),
        );
      },
    );
  }

  List<Widget> _list(
    int start,
    int index,
  ) {
    return List<Widget>.generate(
      index,
      (int index) {
        return Center(
          child: Text(
            index < start ? '0${++index}' : (++index).toString(),
          ),
        );
      },
    );
  }

  _picker(int index) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 188, 188, 188),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoButton(
                  onPressed: () => dialog.hide(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                  child: const Text(
                    'Completed',
                  ),
                )
              ],
            ),
          ),
          _myPageBottomPicker(
            Custom24Picker(
              backgroundColor: Colors.grey,
              looping: true,
              itemExtent: 32,
              magnification: 1.1,
              scrollControllers: [
                FixedExtentScrollController(initialItem: 0),
                FixedExtentScrollController(initialItem: 0),
                FixedExtentScrollController(initialItem: 0),
                FixedExtentScrollController(initialItem: 0),
              ],
              onSelectedItemChanged: (List<int> list) {
                setState(() {
                  if (list.last == 0) {
                    bornList[index][0] = '${list.first + 1990}';
                  } else if (list.last == 1) {
                    bornList[index][1] = '${list.first + 1}'.padLeft(2, '0');
                  } else if (list.last == 2) {
                    bornList[index][2] = '${list.first + 1}'.padLeft(2, '0');
                  } else if (list.last == 3) {
                    bornList[index][3] = '${list.first + 1}'.padLeft(2, '0');
                  }
                });
              },
              childDelegate: [
                ListWheelChildLoopingListDelegate(children: listYear(9, 2023)),
                ListWheelChildLoopingListDelegate(children: _list(9, 12)),
                ListWheelChildLoopingListDelegate(children: _list(9, 31)),
                ListWheelChildLoopingListDelegate(children: _list(9, 24)),
              ],
              children: [
                listYear(1989, 2023),
                _list(9, 12),
                _list(9, 31),
                _list(9, 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
