import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'overlay_dialog_platform_interface.dart';

/// An implementation of [OverlayDialogPlatform] that uses method channels.
class MethodChannelOverlayDialog extends OverlayDialogPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('overlay_dialog');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
