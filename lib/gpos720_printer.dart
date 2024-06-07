
import 'gpos720_printer_platform_interface.dart';

class Gpos720Printer {
  Future<String?> getPlatformVersion() {
    return Gpos720PrinterPlatform.instance.getPlatformVersion();
  }
}
