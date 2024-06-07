import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gpos720_printer_platform_interface.dart';

/// An implementation of [Gpos720PrinterPlatform] that uses method channels.
class MethodChannelGpos720Printer extends Gpos720PrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpos720_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
