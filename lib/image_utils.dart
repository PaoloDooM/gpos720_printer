import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ImageUtils {
  ///A method that applies a binary filter with dithering to an image, converting it to black and white while using dithering to represent colors that are not too dark.
  ///Parameters:
  ///
  ///-[image] A Uint8List representing the image.
  ///
  ///-[blackTolerance] A double representing the tolerance level for using black color. The default value is 0.34.
  ///
  ///-[ditheringTolerance] A double representing the tolerance for using dithering to represent colors. The default value is 0.67.
  ///
  ///Returns: A [Uint8List] with the filtered image.
  static Future<Uint8List> binaryFilterWithDithering(Uint8List imageData,
      {double? blackTolerance, double? ditheringTolerance}) async {
    final ui.Image image =
        (await (await ui.instantiateImageCodec(imageData)).getNextFrame())
            .image;

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

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final int index = (y * image.width + x) * 4;

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
        outputPixels, image.width, image.height, ui.PixelFormat.rgba8888,
        (ui.Image outputImage) {
      completer.complete(outputImage);
    });

    return (await (await completer.future)
            .toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
