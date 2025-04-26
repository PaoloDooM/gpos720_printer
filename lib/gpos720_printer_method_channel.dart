import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/printer_commands.dart';
import 'package:gpos720_printer/printer_modes.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'font_model.dart';
import 'gpos720_printer_platform_interface.dart';
import 'image_utils.dart';

/// An implementation of [Gpos720PrinterPlatform] that uses method channels.
class MethodChannelGpos720Printer extends Gpos720PrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpos720_printer');

  @override
  Future<String> getPlatformVersion() async {
    return (await methodChannel
            .invokeMethod<String>(PrinterCommands.getPlatformVersion.label)) ??
        "-1";
  }

  @override
  Future<PrinterStatus> checkPrinter() async {
    int? status = int.tryParse(await methodChannel
            .invokeMethod<String>(PrinterCommands.checkPrinter.label) ??
        '');
    return PrinterStatus.values[status ?? PrinterStatus.unknownStatus.index];
  }

  @override
  Future<PrinterStatus> endPrinting() async {
    int? status = int.tryParse(await methodChannel
            .invokeMethod<String>(PrinterCommands.endPrinting.label) ??
        '');
    return PrinterStatus.values[status ?? PrinterStatus.unknownStatus.index];
  }

  @override
  Future<PrinterStatus> lineFeed(int lineCount, bool finishPrinting) async {
    await methodChannel.invokeMethod<String>(
        PrinterCommands.lineFeed.label, {"lineCount": lineCount});
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printText(String text, bool finishPrinting,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.text.label,
      "text": text,
      "options": options?.toList() ?? TextOptions().toList(),
      "size": size,
      "font": font?.fontName ?? Font().fontName,
      "align": align.label
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printImage(
      Uint8List imageBytes, int width, int height, bool finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center}) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.image.label,
      "imageBytes": imageBytes,
      "width": width,
      "height": height,
      "align": align.label
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printFilteredImage(
      Uint8List imageBytes, int width, int height, bool finishPrinting,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.image.label,
      "imageBytes": await ImageUtils.binaryFilterWithDithering(imageBytes,
          blackTolerance: blackTolerance,
          ditheringTolerance: ditheringTolerance),
      "width": width,
      "height": height,
      "align": align.label
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printBarcode(String barcode, int width, int height,
      BarcodeTypes barcodeType, bool finishPrinting) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.barcode.label,
      "barcode": barcode,
      "width": width,
      "height": height,
      "barcodeType": barcodeType.label
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printBarcodeImage(String barcode, int width, int height,
      BarcodeTypes barcodeType, bool finishPrinting) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.barcodeImage.label,
      "barcode": barcode,
      "width": width,
      "height": height,
      "barcodeType": barcodeType.label
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }

  @override
  Future<PrinterStatus> printAllFunctions(
      Uint8List imageBytes, int width, int height, bool finishPrinting) async {
    await methodChannel.invokeMethod<String>(PrinterCommands.print.label, {
      "printerMode": PrinterModes.allFunctions.label,
      "imageBytes": imageBytes,
      "width": width,
      "height": height
    });
    return finishPrinting ? await endPrinting() : await checkPrinter();
  }
}
