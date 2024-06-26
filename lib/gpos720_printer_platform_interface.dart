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
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<PrinterStatus> checarImpressora() {
    throw UnimplementedError('checarImpressora() has not been implemented.');
  }

  Future<PrinterStatus> avancaLinha(int quantLinhas) {
    throw UnimplementedError(
        'avancaLinha(int quantLinhas) has not been implemented.');
  }

  Future<PrinterStatus> imprimirTexto(String mensagem,
      {TextOptions? options,
      int size = defaultFontSize,
      Font? font,
      AlignmentTypes align = AlignmentTypes.left}) {
    throw UnimplementedError(
        'imprimirTexto(String mensagem, TextOptions options, int size, Font font, AlignmentTypes align) has not been implemented.');
  }

  Future<PrinterStatus> imprimirImagem(Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center}) {
    throw UnimplementedError(
        'imprimirImagem(Uint8List data, int width, int height, AlignmentTypes align) has not been implemented.');
  }

  Future<PrinterStatus> imprimirImagemFiltrada(
      Uint8List data, int width, int height,
      {AlignmentTypes align = AlignmentTypes.center,
      double? blackTolerance,
      double? ditheringTolerance}) {
    throw UnimplementedError(
        'imprimirImagemFiltrada(Uint8List data, int width, int height, AlignmentTypes align, double? blackTolerance, double? ditheringTolerance) has not been implemented.');
  }

  Future<PrinterStatus> imprimirCodigoDeBarra(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    throw UnimplementedError(
        'imprimirCodigoDeBarra(String mensagem, int width, int height, BarcodeTypes barcodeType) has not been implemented.');
  }

  Future<PrinterStatus> imprimirCodigoDeBarraImg(
      String mensagem, int width, int height, BarcodeTypes barcodeType) {
    throw UnimplementedError(
        'imprimirCodigoDeBarraImg(String mensagem, int width, int height, BarcodeTypes barcodeType) has not been implemented.');
  }

  Future<PrinterStatus> imprimirTodasFuncoes(
      Uint8List data, int width, int height) {
    throw UnimplementedError(
        'imprimirTodasFuncoes(Uint8List data, int width, int height) has not been implemented.');
  }
}
