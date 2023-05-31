import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'overlay_dialog_method_channel.dart';

abstract class OverlayDialogPlatform extends PlatformInterface {
  /// Constructs a OverlayDialogPlatform.
  OverlayDialogPlatform() : super(token: _token);

  static final Object _token = Object();

  static OverlayDialogPlatform _instance = MethodChannelOverlayDialog();

  /// The default instance of [OverlayDialogPlatform] to use.
  ///
  /// Defaults to [MethodChannelOverlayDialog].
  static OverlayDialogPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OverlayDialogPlatform] when
  /// they register themselves.
  static set instance(OverlayDialogPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
