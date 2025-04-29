# gpos720_printer

A Flutter plugin to integrate printing in the <a href="https://www.gertec.com.br/produtos/gpos720/">
Gertec GPOS720</a>.

<div align="center">
  <img src="https://raw.githubusercontent.com/PaoloDooM/gpos720_printer/master/GPOS720.png" alt="gpos720" height="400" />
  <br/>
  <br/>
  <img src="https://raw.githubusercontent.com/PaoloDooM/gpos720_printer/master/example.gif" alt="example" height="400" />
</div>

## Features

| Methods                  | Implemented |
|:-------------------------|:-----------:|
| checkPrinter         |     ✔️      |
| lineFeed              |     ✔️      |
| printText            |     ✔️      |
| printImage           |     ✔️      |
| printFilteredImage   |     ✔️      |
| printBarcode    |     ✔️      |
| printBarcodeImage |     ✔️      |
| printAllFunctions     |     ✔️      |
| imprimirEscPos           |     ❌️      |

## Requirements

* <b>Android SDK version</b> >= 22.
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

### Step 3

You might need to add ProGuard rules to ensure the native Android code in the library isn't 
obfuscated or removed during minification. To do this, navigate to 
the <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/example/android/app/proguard-rules.pro">android/app/proguard-rules.pro</a>
file in your app's directory. If it doesn't exist, create it. In this file, you should add the 
following rules:

```proguard
...
-keep class br.com.gertec.** { *; }
-dontwarn br.com.gertec.**
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
  Gpos720Printer gpos720Printer = Gpos720Printer(finishPrintingAfterEachCommand: false);
}
```

> You can pass the optional boolean parameter `finishPrintingAfterEachCommand` in the constructor to call
> the `endPrinting` function after executing a print command. By default, this parameter is set
> to `false`, so it might be necessary to call `endPrinting` after executing all the desired print
> commands.

## Documentation

### Methods:

#### <code>Future\<PrinterStatus\> checkPrinter()</code>

* Description: Checks the printer’s status.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> endPrinting()</code>

* Description: Prints all buffered printer commands.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> lineFeed(int lineCount)</code>

* Description: Adds line breaks to the current printout.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>lineCount</b>: An Integer specifying the desired number of line breaks.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printText(String text, {TextOptions? options, int size = defaultFontSize, Font? font, AlignmentTypes align = AlignmentTypes.left})</code>

* Description: Prints text.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>text</b>: A String with the desired text to be printed.
2. <b>options (optional)</b>: A TextOptions specifying if the text will be render as bold, italic or
   underlined.
3. <b>size (optional)</b>: An Integer specifying the desired font size.
4. <b>Font (optional)</b>: A Font specifying the desired font to be used in the text.
5. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be left.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printImage(Uint8List imageBytes, int width, int height, {AlignmentTypes align = AlignmentTypes.center})</code>

* Description: Prints raw black and white images only. You can use the
  method <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/image_utils.dart">
  binaryFilterWithDithering</a> to apply a binary filter with dithering to the image.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>imageBytes</b>: A Uint8List with the raw data of the black and white image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be center.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printFilteredImage(Uint8List imageBytes, int width, int height, {AlignmentTypes align = AlignmentTypes.center, double? blackTolerance, double? ditheringTolerance})</code>

* Description: Apply a binary filter with dithering and print the raw image.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>imageBytes</b>: A Uint8List with the raw data of the image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be center.
5. <b>blackTolerance (optional)</b>: A double representing the tolerance level for using black
   color. The
   default value is 0.34.
6. <b>ditheringTolerance (optional)</b>: A double representing the tolerance for using dithering to
   represent
   colors. The default value is 0.67.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printBarcode(String barcode, int width, int height, BarcodeTypes barcodeType)</code>

* Description: Prints various types of barcodes.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>barcode</b>: A String specifying the desired data on the barcode.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>barcodeType</b>: A BarcodeTypes enum specifying the desired barcode type.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printBarcodeImage(String barcode, int width, int height, BarcodeTypes barcodeType)</code>

* Description: Prints various types of barcodes, rendering them as images.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>barcode</b>: A String specifying the desired data on the barcode.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.
4. <b>barcodeType</b>: A BarcodeTypes enum specifying the desired barcode type.

* Throws: A PlatformException or a MissingPluginException.

#### <code>Future\<PrinterStatus\> printAllFunctions(Uint8List imageBytes, int width, int height)</code>

* Description: Prints all printer functions.
* Returns:
  A <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>imageBytes</b>: A Uint8List with the raw data of the black and white image.
2. <b>width</b>: An Integer specifying the desired width.
3. <b>height</b>: An Integer specifying the desired height.

* Throws: A PlatformException or a MissingPluginException.

### Configuration parameters:

#### <code>BarcodeTypes</code>

An enum to indicate the type of barcode to be
printed. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/barcode_types.dart">
Click here</a> to consult the available types.

#### <code>AlignmentTypes</code>

An enum to indicate the desired alignment for the command to be
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
the "message"
getter. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
Click here</a> to view the implementation.

### ImageUtils:

#### <code>binaryFilterWithDithering</code>

A method that applies a binary filter with dithering to an image, converting it to black and white
while using dithering to represent colors that are not too dark. The method takes the following
parameters:

- `imageBytes`: A `Uint8List` representing the image.
- `blackTolerance`: A `double` representing the tolerance level for using black color. The default
  value is 0.34.
- `ditheringTolerance`: A `double` representing the tolerance for using dithering to represent
  colors. The default value is 0.67.

Returns: A `Uint8List` with the filtered image.

<a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/image_utils.dart">Click
here</a> to view the implementation.

## TODO

* Implement plugin tests.
* Print raw ESC/POS commands.
