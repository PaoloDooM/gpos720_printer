import 'package:flutter_test/flutter_test.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/gpos720_printer_platform_interface.dart';
import 'package:gpos720_printer/gpos720_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGpos720PrinterPlatform
    with MockPlatformInterfaceMixin
    implements Gpos720PrinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Gpos720PrinterPlatform initialPlatform = Gpos720PrinterPlatform.instance;

  test('$MethodChannelGpos720Printer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGpos720Printer>());
  });

  test('getPlatformVersion', () async {
    Gpos720Printer gpos720PrinterPlugin = Gpos720Printer();
    MockGpos720PrinterPlatform fakePlatform = MockGpos720PrinterPlatform();
    Gpos720PrinterPlatform.instance = fakePlatform;

    expect(await gpos720PrinterPlugin.getPlatformVersion(), '42');
  });
}
