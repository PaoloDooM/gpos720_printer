# gpos720_printer

A Flutter plugin to integrate printing in the <a href="https://www.gertec.com.br/produtos/gpos720/">
Gertec GPOS720</a>.

## Features

| Methods               | Implemented |
|:----------------------|:-----------:|
| checarImpressora      |     ✔️      |
| fimImpressao          |     ✔️      |
| avancaLinha           |     ✔️      |
| imprimirTexto         |     ✔️      |
| imprimirImagem        |     ✔️      |
| imprimirCodigoDeBarra |     ✔️      |
| imprimirTodasFuncoes  |     ✔️      |
| imprimirEscPos        |     ❌️      |

## Requirements

* <b>Android minimum sdk version</b> >= 22.
* <b>Flutter version</b> >= 2.0.0.
* <b>Dart version</b> >= 2.12.0.

## Instalation

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

## Documumentation

### Methods:

#### <code><b>Future<String?> avancaLinha(int quantLinhas)</b></code>

* Description: Adds line breaks to the current printout.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>quantLinhas</b>: An Integer specifying the desired number of line breaks.

* Throws: A PlatformException or a MissingPluginException.

#### <code><b>Future<String?> checarImpressora()</b></code>

* Description: Checks the printer’s status.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Throws: A PlatformException or a MissingPluginException.

#### <code><b>Future<String?> fimImpressao()</b></code>

* Description: Finalizes the printing queue.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Throws: A PlatformException or a MissingPluginException.

#### <code><b>Future<String?> imprimirCodigoDeBarra(String mensagem, int width, int height, BarcodeTypes barcodeType)</b></code>

* Description: Prints various types of barcodes.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>mensagem</b>: A String specifying the desired data on the barcode.
2. <b>width</b>: An Integer specifing the desired width.
3. <b>height</b>: An Integer specifing the desired height.
4. <b>barcodeTypes</b>: A BarcodeTypes enum specifing the desired barcode type.

* Throws: A PlatformException or a MissingPluginException.

#### <code><b>Future<String?> imprimirImagem(Uint8List data, int width, int height, {AlignmentTypes align = AlignmentTypes.center})</b></code>

* Description: Prints raw images.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>data</b>: A Uint8List with the image raw data.
2. <b>width</b>: An Integer specifing the desired width.
3. <b>height</b>: An Integer specifing the desired height.
4. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be center.

* Throws: A PlatformException or a MissingPluginException.

#### <code><b>imprimirTexto(String mensagem, {TextOptions? options, int size = defaultFontSize, Font? font, AlignmentTypes align = AlignmentTypes.left})</b></code>

* Description: Prints text.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>mensagem</b>: A String with the desired text to be printed.
2. <b>options (optional)</b>: A TextOptions specifing if the text will be render as bold, italic or
   underlined.
3. <b>size (optional)</b>: An Integer specifing the desired font size.
4. <b>Font (optional)</b>: A Font specifing the desired font to be used in the text.
5. <b>align (optional)</b>: An AlignmentTypes enum specifying the desired alignment. By default,
   align will be left.

* Throws: A PlatformException or a MissingPluginException.

#### <code><b>Future<String?> imprimirTodasFuncoes(Uint8List data, int width, int height)</b></code>

* Description: Prints all printer functions.
* Returns:
  An <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
  PrinterStatus</a> enum indicating the printer’s status.
* Parameters:

1. <b>data</b>: A Uint8List with the image raw data.
2. <b>width</b>: An Integer specifing the desired width.
3. <b>height</b>: An Integer specifing the desired height.

* Throws: A PlatformException or a MissingPluginException.

### Configutarion parameters:

#### <code><b>BarcodeTypes</b></code>

An enum to indicate the type of barcode to be
printed. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/barcode_types.dart">
Click here</a> to consult the available types.

#### <code><b>AlignmentTypes</b></code>

An enum to indicate the type of barcode to be
printed. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/alignment_types.dart">
Click here</a> to consult the available types.

#### <code><b>Font</b></code>

An object to specify the desired font for printing. The constructor receives the font name as a
parameter, and the font must be available in the assets folder under the directory "/fonts". By
default, it is set to "
NORMAL", <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/font_model.dart">
click here</a> to view the implementation.

#### <code><b>TextOptions</b></code>

An object that specifies the desired text decoration. It can add bold, italic, or underline styles.
By default, all styles are set to
false, <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/text_options.dart">
click here</a> to view the implementation.

### Output:

#### <code><b>PrinterStatus</b></code>

An enum to indicate the current status of the
printer, it can be parsed to a String using
the ".getLabel()"
method. <a href="https://github.com/PaoloDooM/gpos720_printer/blob/master/lib/printer_status.dart">
Click here</a> to view the implementation.

## TODO

* Pass image data from outside the MethodChannel to avoid payload size/speed limitations.
* Implement plugin tests.
* Standarize exceptions outputs.
* Print raw ESC/POS commands.
