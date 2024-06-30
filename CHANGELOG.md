## 0.0.1

* Initial release.

## 0.0.2

* Add topics to the package.
* Refactor to return a string representation of the printer status on print commands.
* Adds a StatusPrinter enum and a method to parse it from a string.

## 0.0.3

* Fixes typos on README.md.

## 0.0.4

* Refactor to return a enum representation of the printer status on print commands.

## 0.0.5

* Updated the README.md to reflect the latest modifications.

## 0.0.5+1

* Formatting and corrections in the README.md.

## 0.0.6

* Fixes invalid arguments in method <code>imprimirTexto</code>.

## 0.0.6+1

* Formatting corrections in the CHANGELOG.md.

## 0.0.6+2

* Fixes typos on README.md.

## 0.0.6+3

* Fixes more typos on README.md.

## 0.0.7

* Reconfiguration of default values.
* Refactor in <code>getLabel</code> methods.
* Updated README.md.

## 0.0.7+1

* Formatting in the README.md.

## 0.0.7+2

* Updated example.

## 0.0.8

* Refactor from method <code>bool PrinterStatus.isImpressoraOK()</code> to getter <code>bool PrinterStatus.isImpressoraOK</code>.

## 0.0.9

* Add the method <code>Future<PrinterStatus> imprimirCodigoDeBarraImg(String mensagem, int width, int height, BarcodeTypes barcodeType)</code>.
* Remove the method <code>Future<PrinterStatus> fimImpressao()</code> and call it after every printer command.
* Updated README.md and example.

## 0.0.10

* Updated README.md and example.

## 0.0.10+1

* Updated example.

## 1.0.0

* Add a method that prints images, filtering them to black and white using a binary filter.
* Add a utility method to apply a binary filter to images.
* Updated README.md and example.

## 1.1.0

* Refactor of the binary filter, now implements dithering to represent not too dark colors.
* Updated README.md and example.