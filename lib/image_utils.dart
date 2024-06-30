import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ImageUtils {
  static Future<Uint8List> binaryFilterWithDithering(Uint8List imageData,
      {double? blackTolerance, double? ditheringTolerance}) async {
    final ui.Image image =
        (await (await ui.instantiateImageCodec(imageData)).getNextFrame())
            .image;

    final int width = image.width;
    final int height = image.height;

    final Uint8List pixels =
        (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!
            .buffer
            .asUint8List();
    final Uint8List outputPixels = Uint8List(pixels.length);

    blackTolerance = blackTolerance ?? 0.34;
    ditheringTolerance = ditheringTolerance ?? 0.67;
    assert(blackTolerance >= 0.0 && blackTolerance <= 1.0);
    assert(ditheringTolerance >= 0.0 && ditheringTolerance <= 1.0);

    final int blackThreshold = (blackTolerance * 255).toInt();
    final int ditheringThreshold = (ditheringTolerance * 255).toInt();

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int index = (y * width + x) * 4;

        final int r = pixels[index];
        final int g = pixels[index + 1];
        final int b = pixels[index + 2];
        final int a = pixels[index + 3];

        if (a == 0) {
          outputPixels[index] = 255;
          outputPixels[index + 1] = 255;
          outputPixels[index + 2] = 255;
          outputPixels[index + 3] = 255;
          continue;
        }

        final int gray = (0.3 * r + 0.59 * g + 0.11 * b).toInt();

        if (gray <= blackThreshold) {
          outputPixels[index] = 0;
          outputPixels[index + 1] = 0;
          outputPixels[index + 2] = 0;
          outputPixels[index + 3] = 255;
        } else {
          final int threshold = ((x + y) % 2) == 0
              ? ditheringThreshold
              : 255 - ditheringThreshold;
          if (gray <= threshold) {
            outputPixels[index] = 0;
            outputPixels[index + 1] = 0;
            outputPixels[index + 2] = 0;
            outputPixels[index + 3] = 255;
          } else {
            outputPixels[index] = 255;
            outputPixels[index + 1] = 255;
            outputPixels[index + 2] = 255;
            outputPixels[index + 3] = 255;
          }
        }
      }
    }

    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromPixels(
        outputPixels, width, height, ui.PixelFormat.rgba8888,
        (ui.Image outputImage) {
      completer.complete(outputImage);
    });

    return (await (await completer.future)
            .toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
