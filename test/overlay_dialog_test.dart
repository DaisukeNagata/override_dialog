import 'package:flutter_test/flutter_test.dart';
import 'package:override_dialog/override_dialog.dart';
import 'package:override_dialog/override_dialog_method_channel.dart';
import 'package:override_dialog/override_dialog_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOverlayDialogPlatform
    with MockPlatformInterfaceMixin
    implements OverrideDialogPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OverrideDialogPlatform initialPlatform =
      OverrideDialogPlatform.instance;

  test('$MethodChannelOverrideDialog is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOverrideDialog>());
  });

  test('getPlatformVersion', () async {
    OverrideDialog overlayDialogPlugin = OverrideDialog();
    MockOverlayDialogPlatform fakePlatform = MockOverlayDialogPlatform();
    OverrideDialogPlatform.instance = fakePlatform;

    expect(await overlayDialogPlugin.getPlatformVersion(), '42');
  });
}
