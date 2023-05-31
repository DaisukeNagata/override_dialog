import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'override_dialog_method_channel.dart';

abstract class OverrideDialogPlatform extends PlatformInterface {
  /// Constructs a OverrideDialogPlatform.
  OverrideDialogPlatform() : super(token: _token);

  static final Object _token = Object();

  static OverrideDialogPlatform _instance = MethodChannelOverrideDialog();

  /// The default instance of [OverrideDialogPlatform] to use.
  ///
  /// Defaults to [MethodChannelOverrideDialog].
  static OverrideDialogPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OverrideDialogPlatform] when
  /// they register themselves.
  static set instance(OverrideDialogPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
