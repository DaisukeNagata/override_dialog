import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'override_dialog_platform_interface.dart';

/// An implementation of [OverrideDialogPlatform] that uses method channels.
class MethodChannelOverrideDialog extends OverrideDialogPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('override_dialog');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
