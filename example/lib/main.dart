import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gpos720_printer/alignment_types.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/font_model.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/status_printer.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imgn;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(useMaterial3: false), home: const Example());
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final Gpos720Printer gpos720PrinterPlugin = Gpos720Printer();
  final ScrollController scrollbarController = ScrollController();
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Elementum pulvinar etiam non quam lacus. Vitae tortor condimentum lacinia quis vel eros. Massa sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper morbi tincidunt ornare massa eget egestas. Molestie at elementum eu facilisis sed odio morbi quis. Tincidunt ornare massa eget egestas purus viverra accumsan in. Augue ut lectus arcu bibendum at. Sem et tortor consequat id porta. Purus sit amet luctus venenatis lectus magna. Nunc lobortis mattis aliquam faucibus purus in massa tempor nec. Fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien. Accumsan sit amet nulla facilisi morbi tempus. Imperdiet proin fermentum leo vel orci porta non. Amet mauris commodo quis imperdiet.";

  Future<String?> getPlatform() async {
    return await gpos720PrinterPlugin.getPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('gpos720_printer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String?>(
                  future: getPlatform(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                          child: Text(
                              'Running on: ${snapshot.data ?? 'Unknown platform version'}'));
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text(
                              'Running on: Failed to get platform version.'));
                    }
                    return Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Running on: '),
                        Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(left: 15),
                            child: const CircularProgressIndicator())
                      ],
                    ));
                  }),
            ),
            Expanded(
              child: Scrollbar(
                controller: scrollbarController,
                thumbVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    controller: scrollbarController,
                    children: [
                      methodCardBuilder(
                          context,
                          "checarImpressora",
                          "Checks the printer’s status.",
                          () async => gpos720PrinterPlugin.checarImpressora()),
                      methodCardBuilder(context, "imprimirTodasFuncoes",
                          "Prints all printer functions.", () async {
                        Uint8List bytes =
                            (await rootBundle.load("assets/flutter.png"))
                                .buffer
                                .asUint8List();
                        imgn.Image image = imgn.decodeImage(bytes.toList())!;
                        return await gpos720PrinterPlugin.imprimirTodasFuncoes(
                            bytes, image.height, image.width);
                      }),
                      methodCardBuilder(
                          context,
                          "imprimirCodigoDeBarra",
                          "Prints various types of barcodes.",
                          () async =>
                              await gpos720PrinterPlugin.imprimirCodigoDeBarra(
                                  "https://www.google.com/",
                                  200,
                                  200,
                                  BarcodeTypes.qrCode)),
                      methodCardBuilder(
                          context, "imprimirImagem", "Prints raw images.",
                          () async {
                        Uint8List bytes =
                            (await rootBundle.load("assets/flutter.png"))
                                .buffer
                                .asUint8List();
                        imgn.Image image = imgn.decodeImage(bytes.toList())!;
                        return await gpos720PrinterPlugin.imprimirImagem(
                            bytes, image.height, image.width,
                            align: AlignmentTypes.center);
                      }),
                      methodCardBuilder(
                          context,
                          "imprimirTexto",
                          "Prints text.",
                          () async => await gpos720PrinterPlugin.imprimirTexto(
                              loremIpsum,
                              align: AlignmentTypes.right,
                              size: defaultFontSize,
                              font: Font(fontName: 'NORMAL'),
                              options: TextOptions(
                                  bold: false,
                                  italic: false,
                                  underlined: false))),
                      methodCardBuilder(
                        context,
                        "avancaLinha",
                        "Adds line breaks to the current printout.",
                        () async => await gpos720PrinterPlugin.avancaLinha(5),
                      ),
                      methodCardBuilder(
                          context,
                          "fimImpressao",
                          "Finalizes the printing queue.",
                          () async =>
                              await gpos720PrinterPlugin.fimImpressao()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget methodCardBuilder(BuildContext context, String title, String subtitle,
      Future<String?> Function() method) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          child: const Text("Print"),
          onPressed: () async {
            try {
              _dialogBuilder(context, message: await method());
            } catch (e) {
              _dialogBuilder(context, message: e.toString(), success: false);
            }
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context,
      {String? message, bool success = true}) {
    ScrollController dialogScrollController = ScrollController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            actionsPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.all(20),
            title: success
                ? Text('Printing success',
                    style: TextStyle(
                        color: Colors.green[700], fontWeight: FontWeight.bold))
                : Text('Printing failure',
                    style: TextStyle(
                        color: Colors.red[700], fontWeight: FontWeight.bold)),
            content: Scrollbar(
                controller: dialogScrollController,
                thumbVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                      controller: dialogScrollController,
                      child: Text(success
                          ? statusPrinterFromString(message).getLabel()
                          : message ?? "Empty response")),
                )),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
