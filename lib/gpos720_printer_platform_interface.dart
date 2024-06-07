import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gpos720_printer_method_channel.dart';

abstract class Gpos720PrinterPlatform extends PlatformInterface {
  /// Constructs a Gpos720PrinterPlatform.
  Gpos720PrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static Gpos720PrinterPlatform _instance = MethodChannelGpos720Printer();

  /// The default instance of [Gpos720PrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGpos720Printer].
  static Gpos720PrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Gpos720PrinterPlatform] when
  /// they register themselves.
  static set instance(Gpos720PrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
