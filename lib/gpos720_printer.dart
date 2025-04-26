import 'dart:typed_data';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'font_model.dart';
import 'gpos720_printer_platform_interface.dart';

class Gpos720Printer {
  final bool finishPrintingAfterEachCommand;

  ///Constructor for the [Gpos720Printer] class.
  ///Parameters: An optional boolean parameter [finishPrintingAfterEachCommand] that calls the [endPrinting] function after executing a print command. By default, this parameter is false, so it might be necessary to call [endPrinting] after executing all the desired print commands.
  Gpos720Printer({this.finishPrintingAfterEachCommand = false});

  Future<String> getPlatformVersion() {
    return Gpos720PrinterPlatform.instance.getPlatformVersion();
  }

  ///Checks the printer’s status.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> checkPrinter() {
    return Gpos720PrinterPlatform.instance.checkPrinter();
  }

  ///Prints all buffered printer commands.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> endPrinting() {
    return Gpos720PrinterPlatform.instance.endPrinting();
  }

  ///Adds line breaks to the current printout.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters: [lineCount] An Integer specifying the desired number of line breaks.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> lineFeed(int lineCount) {
    return Gpos720PrinterPlatform.instance
        .lineFeed(lineCount, finishPrintingAfterEachCommand);
  }

  ///Prints text.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[text] A String with the desired text to be printed.
  ///
  ///-[options] (optional) A [TextOptions] specifying if the text will be render as bold, italic or underlined.
  ///
  ///-[size] (optional) An Integer specifying the desired font size.
  ///
  ///-[Font] (optional) A [Font] specifying the desired font to be used in the text.
  ///
  ///-[align] (optional) An [AlignmentTypes] enum specifying the desired alignment. By default, align will be left.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printText(String text,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    return Gpos720PrinterPlatform.instance.printText(
        text, finishPrintingAfterEachCommand,
        options: options, size: size, font: font, align: align);
  }

  ///Prints raw black and white images only. You can use the [ImageUtils.binaryFilterWithDithering] to apply a binary filter with dithering to the image.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[imageBytes] A Uint8List with the raw data of the black and white image.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[align] (optional) An [AlignmentTypes] enum specifying the desired alignment. By default, align will be center.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printImage(Uint8List imageBytes, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    return Gpos720PrinterPlatform.instance.printImage(
        imageBytes, width, height, finishPrintingAfterEachCommand,
        align: align);
  }

  ///Apply a binary filter with dithering and print the raw image.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[imageBytes] A Uint8List with the raw data of the image.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[align] (optional) An [AlignmentTypes] enum specifying the desired alignment. By default, align will be center.
  ///
  ///-[blackTolerance] (optional) A double representing the tolerance level for using black color. The default value is 0.34.
  ///
  ///-[ditheringTolerance] (optional) A double representing the tolerance for using dithering to represent colors. The default value is 0.67.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printFilteredImage(
      Uint8List imageBytes, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) {
    return Gpos720PrinterPlatform.instance.printFilteredImage(
        imageBytes, width, height, finishPrintingAfterEachCommand,
        align: align,
        blackTolerance: blackTolerance,
        ditheringTolerance: ditheringTolerance);
  }

  ///Prints various types of barcodes.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[barcode] A String specifying the desired data on the barcode.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[barcodeType] A [BarcodeTypes] enum specifying the desired barcode type.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printBarcode(
      String barcode, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance.printBarcode(
        barcode, width, height, barcodeType, finishPrintingAfterEachCommand);
  }

  ///Prints various types of barcodes, rendering them as images.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[barcode] A String specifying the desired data on the barcode.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[barcodeType] A [BarcodeTypes] enum specifying the desired barcode type.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printBarcodeImage(
      String barcode, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance.printBarcodeImage(
        barcode, width, height, barcodeType, finishPrintingAfterEachCommand);
  }

  ///Prints all printer functions.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[imageBytes] A Uint8List with the raw data of the black and white image.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> printAllFunctions(
      Uint8List imageBytes, int width, int height) {
    return Gpos720PrinterPlatform.instance.printAllFunctions(
        imageBytes, width, height, finishPrintingAfterEachCommand);
  }
}
