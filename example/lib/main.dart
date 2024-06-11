import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
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
  String _platformVersion = 'Unknown';
  final _gpos720PrinterPlugin = Gpos720Printer();
  final scrollbarController = ScrollController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _gpos720PrinterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('gpos720_printer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(child: Text('Running on: $_platformVersion\n')),
              Expanded(
                child: Scrollbar(
                  controller: scrollbarController,
                  child: ListView(
                    controller: scrollbarController,
                    children: [
                      Card(
                        child: ListTile(
                          title: const Text("checarImpressora"),
                          subtitle: const Text("Checks the printer’s status."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              await _gpos720PrinterPlugin.checarImpressora();
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("imprimirTodasFuncoes"),
                          subtitle: const Text("Prints all printer functions."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              Uint8List bytes =
                                  (await rootBundle.load("assets/flutter.png"))
                                      .buffer
                                      .asUint8List();
                              imgn.Image image =
                                  imgn.decodeImage(bytes.toList())!;
                              await _gpos720PrinterPlugin.imprimirTodasFuncoes(
                                  bytes, image.height, image.width);
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("imprimirCodigoDeBarra"),
                          subtitle:
                              const Text("Prints various types of barcodes."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              await _gpos720PrinterPlugin.imprimirCodigoDeBarra(
                                  "https://www.google.com/",
                                  200,
                                  200,
                                  BarcodeTypes.qrCode);
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("imprimirImagem"),
                          subtitle: const Text("Prints raw images."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              Uint8List bytes =
                                  (await rootBundle.load("assets/flutter.png"))
                                      .buffer
                                      .asUint8List();
                              imgn.Image image =
                                  imgn.decodeImage(bytes.toList())!;
                              await _gpos720PrinterPlugin.imprimirImagem(
                                  bytes, image.height, image.width);
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("imprimirTexto"),
                          subtitle: const Text("Prints text."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              await _gpos720PrinterPlugin.imprimirTexto(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Elementum pulvinar etiam non quam lacus. Vitae tortor condimentum lacinia quis vel eros. Massa sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper morbi tincidunt ornare massa eget egestas. Molestie at elementum eu facilisis sed odio morbi quis. Tincidunt ornare massa eget egestas purus viverra accumsan in. Augue ut lectus arcu bibendum at. Sem et tortor consequat id porta. Purus sit amet luctus venenatis lectus magna. Nunc lobortis mattis aliquam faucibus purus in massa tempor nec. Fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien. Accumsan sit amet nulla facilisi morbi tempus. Imperdiet proin fermentum leo vel orci porta non. Amet mauris commodo quis imperdiet.");
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("avancaLinha"),
                          subtitle: const Text(
                              "Adds line breaks to the current printout."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              await _gpos720PrinterPlugin.avancaLinha(5);
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("fimImpressao"),
                          subtitle: const Text("Finalizes the printing queue."),
                          trailing: ElevatedButton(
                            child: const Text("Print"),
                            onPressed: () async {
                              await _gpos720PrinterPlugin.fimImpressao();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
