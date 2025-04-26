import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpos720_printer/alignment_types.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/font_model.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/gpos720_printer_platform_interface.dart';
import 'package:gpos720_printer/gpos720_printer_method_channel.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGpos720PrinterPlatform
    with MockPlatformInterfaceMixin
    implements Gpos720PrinterPlatform {
  @override
  Future<String> getPlatformVersion() => Future.value('42');

  @override
  Future<PrinterStatus> checkPrinter() {
    // TODO: implement checkPrinter
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> endPrinting() {
    // TODO: implement endPrinting
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> lineFeed(int lineCount, finishPrinting) {
    // TODO: implement lineFeed
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printText(String text, finishPrinting,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    // TODO: implement printText
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printImage(
      Uint8List imageBytes, int width, int height, finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center}) {
    // TODO: implement printImage
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printFilteredImage(
      Uint8List imageBytes, int width, int height, finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) {
    // TODO: implement printFilteredImage
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printBarcode(String barcode, int width, int height,
      BarcodeTypes barcodeType, finishPrinting) {
    // TODO: implement printBarcode
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printBarcodeImage(String barcode, int width, int height,
      BarcodeTypes barcodeType, finishPrinting) {
    // TODO: implement printBarcodeImage
    return Future.value(PrinterStatus.printerOk);
  }

  @override
  Future<PrinterStatus> printAllFunctions(
      Uint8List imageBytes, int width, int height, finishPrinting) {
    // TODO: implement printAllFunctions
    return Future.value(PrinterStatus.printerOk);
  }
}

void main() {
  final Gpos720PrinterPlatform initialPlatform =
      Gpos720PrinterPlatform.instance;

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
