import 'package:flutter_test/flutter_test.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:overlay_dialog/overlay_dialog_platform_interface.dart';
import 'package:overlay_dialog/overlay_dialog_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOverlayDialogPlatform
    with MockPlatformInterfaceMixin
    implements OverlayDialogPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OverlayDialogPlatform initialPlatform = OverlayDialogPlatform.instance;

  test('$MethodChannelOverlayDialog is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOverlayDialog>());
  });

  test('getPlatformVersion', () async {
    OverlayDialog overlayDialogPlugin = OverlayDialog();
    MockOverlayDialogPlatform fakePlatform = MockOverlayDialogPlatform();
    OverlayDialogPlatform.instance = fakePlatform;

    expect(await overlayDialogPlugin.getPlatformVersion(), '42');
  });
}
