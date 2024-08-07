import 'dart:typed_data';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'alignment_types.dart';
import 'barcode_types.dart';
import 'font_model.dart';
import 'gpos720_printer_platform_interface.dart';

class Gpos720Printer {
  final bool finalizarImpressao;

  ///Constructor for the [Gpos720Printer] class.
  ///Parameters: An optional boolean parameter [finalizarImpressao] that calls the [fimImpressao] function after executing a print command. By default, this parameter is false, so it might be necessary to call [fimImpressao] after executing all the desired print commands.
  Gpos720Printer({this.finalizarImpressao = false});

  Future<String> getPlatformVersion() {
    return Gpos720PrinterPlatform.instance.getPlatformVersion();
  }

  ///Checks the printer’s status.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> checarImpressora() {
    return Gpos720PrinterPlatform.instance.checarImpressora();
  }

  ///Prints all buffered printer commands.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> fimImpressao() {
    return Gpos720PrinterPlatform.instance.fimImpressao();
  }

  ///Adds line breaks to the current printout.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters: [quantLinhas] An Integer specifying the desired number of line breaks.
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> avancaLinha(int quantLinhas) {
    return Gpos720PrinterPlatform.instance
        .avancaLinha(quantLinhas, finalizarImpressao);
  }

  ///Prints text.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[mensagem] A String with the desired text to be printed.
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
  Future<PrinterStatus> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    return Gpos720PrinterPlatform.instance.imprimirTexto(
        mensagem, finalizarImpressao,
        options: options, size: size, font: font, align: align);
  }

  ///Prints raw black and white images only. You can use the [ImageUtils.binaryFilterWithDithering] to apply a binary filter with dithering to the image.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[data] A Uint8List with the raw data of the black and white image.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[align] (optional) An [AlignmentTypes] enum specifying the desired alignment. By default, align will be center.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    return Gpos720PrinterPlatform.instance
        .imprimirImagem(data, width, height, finalizarImpressao, align: align);
  }

  ///Apply a binary filter with dithering and print the raw image.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[data] A Uint8List with the raw data of the image.
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
  Future<PrinterStatus> imprimirImagemFiltrada(
      Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) {
    return Gpos720PrinterPlatform.instance.imprimirImagemFiltrada(
        data, width, height, finalizarImpressao,
        align: align,
        blackTolerance: blackTolerance,
        ditheringTolerance: ditheringTolerance);
  }

  ///Prints various types of barcodes.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[mensagem] A String specifying the desired data on the barcode.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[barcodeTypes] A [BarcodeTypes] enum specifying the desired barcode type.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance.imprimirCodigoDeBarra(
        mensagem, width, height, barcodeType, finalizarImpressao);
  }

  ///Prints various types of barcodes, rendering them as images.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[mensagem] A String specifying the desired data on the barcode.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///-[barcodeTypes] A [BarcodeTypes] enum specifying the desired barcode type.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> imprimirCodigoDeBarraImg(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    return Gpos720PrinterPlatform.instance.imprimirCodigoDeBarraImg(
        mensagem, width, height, barcodeType, finalizarImpressao);
  }

  ///Prints all printer functions.
  ///Returns: A [PrinterStatus] enum indicating the printer’s status.
  ///Parameters:
  ///
  ///-[data] A Uint8List with the raw data of the black and white image.
  ///
  ///-[width] An Integer specifying the desired width.
  ///
  ///-[height] An Integer specifying the desired height.
  ///
  ///Throws: A [PlatformException] or a [MissingPluginException].
  Future<PrinterStatus> imprimirTodasFuncoes(
      Uint8List data, int width, int height) {
    return Gpos720PrinterPlatform.instance
        .imprimirTodasFuncoes(data, width, height, finalizarImpressao);
  }
}
