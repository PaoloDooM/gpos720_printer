import 'dart:typed_data';
import 'package:flutter_image_filters/flutter_image_filters.dart';
import 'dart:ui' as ui;

class ImageUtils {
  static Future<Uint8List> imageBinaryFilter(Uint8List imageBytes,
      {double? threshold}) async {
    TextureSource texture = await TextureSource.fromMemory(imageBytes);
    LuminanceThresholdShaderConfiguration shader =
        LuminanceThresholdShaderConfiguration();
    shader.threshold = threshold ?? 0.75;
    ui.Image image = await shader.export(
        texture, ui.Size(texture.width.toDouble(), texture.height.toDouble()));

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    throw "The filtered image could not be converted to png";
  }
}
