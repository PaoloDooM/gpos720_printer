# gpos720_printer

A Flutter plugin to integrate printing in the <a href="https://www.gertec.com.br/produtos/gpos720/">
Gertec GPOS720</a>.

## Features

| Methods                  | Implemented |
|:-------------------------|:-----------:|
| checarImpressora         |     ✔️      |
| avancaLinha              |     ✔️      |
| imprimirTexto            |     ✔️      |
| imprimirImagem           |     ✔️      |
| imprimirImagemFiltrada   |     ✔️      |
| imprimirCodigoDeBarra    |     ✔️      |
| imprimirCodigoDeBarraImg |     ✔️      |
| imprimirTodasFuncoes     |     ✔️      |
| imprimirEscPos           |     ❌️      |

## Requirements

* <b>Android minimum sdk version</b> >= 22.
* <b>Flutter version</b> >= 2.0.0.
* <b>Dart version</b> >= 2.12.0.

## Installation

### Step 1

* In the "/android/src/main/AndroidManifest.xml", add:

```xml

<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    ...
    <uses-feature android:name="android.hardware.usb.host" />
    ...
</manifest>
```

### Step 2

The Android Gradle Plugin (AGP) doesn’t support direct local AAR dependencies in Android library
projects due to how it packages the resulting AAR, so we need to do the following configurations.

* In the "/android/app/libs/" directory, paste the two .aar dependencies used by this library. You
  can find them in
  this <a href="https://github.com/PaoloDooM/gpos720_printer/tree/master/android/libs">link</a>.

* Then in the "android/app/build.gradle", add:

```gradle
...
Android{
    ...
    dependencies {
        implementation fileTree(dir: 'libs', include: ['*.aar'])
    }
}
...
```

* Lastly in the "android/build.gradle", add:

```gradle
...
allprojects {
    repositories {
        google()
        mavenCentral()
        flatDir {
            dirs 'libs'
        }
    }
}
...
```

## Getting Started

Just instantiate the "Gpos720Printer" and invoke the desired functions as shown
in <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/example/lib/main.dart">this
example project</a>.

> You must have a Gertec GPOS720 device to be able to use this plugin.

### Instantiate:

Instantiate the "Gpos720Printer" object like this:

```dart
import 'package:gpos720_printer/gpos720_printer.dart';

void main() {
  Gpos720Printer gpos720Printer = Gpos720Printer();
}
```

## Documentation

### Methods:

#### <code>Future\<PrinterStatus\> avancaLinha(int quantLinhas)</code>

* Description: Adds line breaks to the current printout.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>quantLinhas</b>: An Integer specifying the desired number of line breaks.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> checarImpressora()</code>

* Description: Checks the printer’s status.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirCodigoDeBarra(String mensagem, int width, int height, BarcodeTypes barcodeType)</code>

* Description: Prints various types of barcodes.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>mensagem</b>: A String specifying the desired data on the barcode.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>barcodeTypes</b>: A BarcodeTypes enum specifying the desired barcode type.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirCodigoDeBarraImg(String mensagem, int width, int height, BarcodeTypes barcodeType)</code>

* Description: Prints various types of barcodes, rendering them as images.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>mensagem</b>: A String specifying the desired data on the barcode.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>barcodeTypes</b>: A BarcodeTypes enum specifying the desired barcode type.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirImagem(Uint8List data, int width, int height, {AlignmentTypes align = AlignmentTypes.center})</code>

* Description: Prints raw black and white images only. You can use the
  method <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/image_utils.dart">
  imageBinaryFilter</a> to apply a binary filter to the image.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>data</b>: A Uint8List with the raw data of the black and white image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be center.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirImagemFiltrada(Uint8List data, int width, int height, {AlignmentTypes align = AlignmentTypes.center, double? threshold})</code>

* Description: Apply a binary filter and print the raw image.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>data</b>: A Uint8List with the raw data of the image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be center.
5. <b>threshold (optional)</b>: A double that describes luminance threshold manipulations. By
   default, the threshold will be 0.75.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirTexto(String mensagem, {TextOptions? options, int size = defaultFontSize, Font? font, AlignmentTypes align = AlignmentTypes.left})</code>

* Description: Prints text.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>mensagem</b>: A String with the desired text to be printed.
2. <b>options (optional)</b>: A TextOptions specifying if the text will be render as bold, italic or
   underlined.
3. <b>size (optional)</b>: An Integer specifying the desired font size.
4. <b>Font (optional)</b>: A Font specifying the desired font to be used in the text.
5. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be left.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> imprimirTodasFuncoes(Uint8List data, int width, int height)</code>

* Description: Prints all printer functions.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>data</b>: A Uint8List with the raw data of the black and white image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.

* Throws: A PlatformException or a MissingPluginException.

### Configuration parameters:

#### <code>BarcodeTypes</code>

An enum to indicate the type of barcode to be
printed. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/barcode_types.dart">
Click here</a> to consult the available types.

#### <code>AlignmentTypes</code>

An enum to indicate the type of barcode to be
printed. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/alignment_types.dart">
Click here</a> to consult the available types.

#### <code>Font</code>

An object to specify the desired font for printing. The constructor receives the font name as a
parameter, and the font must be available in the assets folder under the directory "/fonts". By
default, it is set to "
NORMAL", <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/font_model.dart">
click here</a> to view the implementation.

#### <code>TextOptions</code>

An object that specifies the desired text decoration. It can add bold, italic, or underline styles.
By default, all styles are set to
false, <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/text_options.dart">
click here</a> to view the implementation.

### Output:

#### <code>PrinterStatus</code>

An enum to indicate the current status of the
printer, it can be parsed to a String using
the ".getLabel"
method. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
Click here</a> to view the implementation.

### ImageUtils:

#### <code>imageBinaryFilter</code>

A method that applies a binary filter to an image, converting it to black and white. It takes the
image as a Uint8List parameter and a threshold representing the color tolerance of the pixel to be
converted to black. By
default, the threshold will be
0.75. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/image_utils.dart">Click
here</a> to view the implementation.

## TODO

* Implement plugin tests.
* Print raw ESC/POS commands.