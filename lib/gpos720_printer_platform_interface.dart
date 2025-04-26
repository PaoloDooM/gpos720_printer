import 'package:flutter/foundation.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'alignment_types.dart';
import 'font_model.dart';
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

  Future<String> getPlatformVersion() {
    throw UnimplementedError('"platformVersion" has not been implemented.');
  }

  Future<PrinterStatus> checkPrinter() {
    throw UnimplementedError('"checkPrinter" has not been implemented.');
  }

  Future<PrinterStatus> endPrinting() {
    throw UnimplementedError('"endPrinting" has not been implemented.');
  }

  Future<PrinterStatus> lineFeed(int lineCount, bool finishPrinting) {
    throw UnimplementedError('"lineFeed" has not been implemented.');
  }

  Future<PrinterStatus> printText(String text, bool finishPrinting,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    throw UnimplementedError('"printText" has not been implemented.');
  }

  Future<PrinterStatus> printImage(
      Uint8List imageBytes, int width, int height, bool finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center}) {
    throw UnimplementedError('"printImage" has not been implemented.');
  }

  Future<PrinterStatus> printFilteredImage(
      Uint8List imageBytes, int width, int height, bool finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) {
    throw UnimplementedError('"printFilteredImage" has not been implemented.');
  }

  Future<PrinterStatus> printBarcode(String barcode, int width, int height,
      BarcodeTypes barcodeType, bool finishPrinting) {
    throw UnimplementedError('"printBarcode" has not been implemented.');
  }

  Future<PrinterStatus> printBarcodeImage(String barcode, int width, int height,
      BarcodeTypes barcodeType, bool finishPrinting) {
    throw UnimplementedError('"printBarcodeImage" has not been implemented.');
  }

  Future<PrinterStatus> printAllFunctions(
      Uint8List imageBytes, int width, int height, bool finishPrinting) {
    throw UnimplementedError('"printAllFunctions" has not been implemented.');
  }
}
