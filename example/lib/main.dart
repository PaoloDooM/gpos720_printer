import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gpos720_printer/alignment_types.dart';
import 'package:gpos720_printer/barcode_types.dart';
import 'package:gpos720_printer/constants.dart';
import 'package:gpos720_printer/font_model.dart';
import 'package:gpos720_printer/gpos720_printer.dart';
import 'package:gpos720_printer/printer_status.dart';
import 'package:gpos720_printer/text_options.dart';
import 'package:flutter/services.dart'
    show
        ByteData,
        MissingPluginException,
        PlatformException,
        Uint8List,
        rootBundle;
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class SnapshotData {
  String platformVersion;
  Uint8List imageData;
  int imageWidth;
  int imageHeight;

  SnapshotData(
      this.platformVersion, this.imageData, this.imageWidth, this.imageHeight);
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
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Elementum pulvinar etiam non quam lacus. Vitae tortor condimentum lacinia quis vel eros. Massa sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper morbi tincidunt ornare massa eget egestas. Molestie at elementum eu facilisis sed odio morbi quis. Tincidunt ornare massa eget egestas purus viverra accumsan in. Augue ut lectus arcu bibendum at. Sem et tortor consequat id porta. Purus sit amet luctus venenatis lectus magna. Nunc lobortis mattis aliquam faucibus purus in massa tempor nec. Fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien. Accumsan sit amet nulla facilisi morbi tempus. Imperdiet proin fermentum leo vel orci porta non. Amet mauris commodo quis imperdiet.";
  final ScrollController scrollbarController = ScrollController();
  final double toolbarHeight = 65;

  Future<SnapshotData> loadAsyncData() async {
    Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(
        (await rootBundle.load("assets/flutter.png")).buffer.asUint8List(),
        (result) {
      completer.complete(result);
    });
    ui.Image convertedImage =
        await convertTransparentToWhite(await completer.future);
    return SnapshotData(
        await gpos720PrinterPlugin.getPlatformVersion(),
        await convertUiImageToUint8List(convertedImage),
        convertedImage.width,
        convertedImage.height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('gpos720_printer'),
      ),
      body: FutureBuilder<SnapshotData>(
          future: loadAsyncData(),
          builder:
              (BuildContext context, AsyncSnapshot<SnapshotData> snapshot) {
            if (snapshot.hasData) {
              return PrimaryScrollController(
                controller: scrollbarController,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollbarController,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: snapshot.data!.imageHeight.toDouble(),
                        toolbarHeight: toolbarHeight,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          centerTitle: false,
                          titlePadding: EdgeInsets.zero,
                          collapseMode: CollapseMode.parallax,
                          title: AnimatedBuilder(
                            animation: scrollbarController,
                            builder: (BuildContext context, Widget? child) {
                              double percentage = ((scrollbarController.offset -
                                          scrollbarController
                                              .initialScrollOffset) /
                                      159)
                                  .clamp(0, 1);
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    'Running on: ${snapshot.data!.platformVersion}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  decoration: ShapeDecoration(
                                      shadows: [
                                        BoxShadow(
                                          color: Color.lerp(Colors.black,
                                              Colors.transparent, percentage)!,
                                          offset: const Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                      color: Color.lerp(Colors.purple,
                                          Colors.transparent, percentage)!,
                                      shape: const StadiumBorder()),
                                ),
                              );
                            },
                          ),
                          background: Container(
                            color: Colors.white,
                            child: Image.memory(snapshot.data!.imageData),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        sliver: SliverList(
                            delegate: SliverChildListDelegate([
                          methodCardBuilder(
                              context,
                              "checarImpressora",
                              "Checks the printer’s status.",
                              () async =>
                                  gpos720PrinterPlugin.checarImpressora()),
                          methodCardBuilder(context, "imprimirTodasFuncoes",
                              "Prints all printer functions.", () async {
                            return await gpos720PrinterPlugin
                                .imprimirTodasFuncoes(
                                    snapshot.data!.imageData,
                                    snapshot.data!.imageHeight,
                                    snapshot.data!.imageWidth);
                          }),
                          methodCardBuilder(context, "imprimirCodigoDeBarra",
                              "Prints various types of barcodes.", () async {
                            return await gpos720PrinterPlugin
                                .imprimirCodigoDeBarra(
                                    "0123456789", 200, 100, BarcodeTypes.upcA);
                          }),
                          methodCardBuilder(context, "imprimirCodigoDeBarraImg",
                              "Prints various types of barcodes, rendering them as images.",
                              () async {
                            return await gpos720PrinterPlugin
                                .imprimirCodigoDeBarraImg(
                                    "https://www.google.com/",
                                    200,
                                    200,
                                    BarcodeTypes.qrCode);
                          }),
                          methodCardBuilder(
                              context, "imprimirImagem", "Prints raw images.",
                              () async {
                            return await gpos720PrinterPlugin.imprimirImagem(
                                snapshot.data!.imageData,
                                snapshot.data!.imageHeight,
                                snapshot.data!.imageWidth,
                                align: AlignmentTypes.center);
                          }),
                          methodCardBuilder(
                              context, "imprimirTexto", "Prints text.",
                              () async {
                            return await gpos720PrinterPlugin.imprimirTexto(
                                loremIpsum,
                                align: AlignmentTypes.right,
                                size: defaultFontSize,
                                font: Font(fontName: 'NORMAL'),
                                options: TextOptions(
                                    bold: false,
                                    italic: false,
                                    underlined: false));
                          }),
                          methodCardBuilder(context, "avancaLinha",
                              "Adds line breaks to the current printout.",
                              () async {
                            return await gpos720PrinterPlugin.avancaLinha(5);
                          }),
                          SizedBox.fromSize(
                            size: ui.Size(MediaQuery.of(context).size.width,
                                snapshot.data!.imageHeight - toolbarHeight),
                          )
                        ])),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              final ScrollController scrollbarController = ScrollController();
              return Center(
                  child: Scrollbar(
                thumbVisibility: true,
                controller: scrollbarController,
                child: SingleChildScrollView(
                  controller: scrollbarController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 90,
                          ),
                        ),
                        Text(
                          '${snapshot.error!}',
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ));
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: const CircularProgressIndicator(),
                ),
                const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ));
          }),
    );
  }

  Widget methodCardBuilder(BuildContext context, String title, String subtitle,
      Future<PrinterStatus> Function() method) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          child: const Text("Print"),
          onPressed: () async {
            try {
              _dialogBuilder(context, (await method()).getLabel);
            } on PlatformException catch (e) {
              _dialogBuilder(context,
                  "${e.code}\n\n${e.message ?? 'Empty message'}\n\n${e.details ?? 'Empty stacktrace'}",
                  success: false);
            } on MissingPluginException catch (e) {
              _dialogBuilder(context,
                  "Not implemented.\n\n${e.message ?? 'Empty message'}",
                  success: false);
            } catch (e) {
              _dialogBuilder(context, e.toString(), success: false);
            }
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String message,
      {bool success = true}) {
    final ScrollController scrollbarController = ScrollController();
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
                controller: scrollbarController,
                thumbVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                      controller: scrollbarController, child: Text(message)),
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

  Future<ui.Image> convertTransparentToWhite(ui.Image image) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();
    canvas.drawImage(image, Offset.zero, paint);
    paint.blendMode = BlendMode.dstOver;
    paint.color = const Color(0xFFFFFFFF);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        paint);
    final picture = pictureRecorder.endRecording();
    final newImage = await picture.toImage(image.width, image.height);
    return newImage;
  }

  Future<Uint8List> convertUiImageToUint8List(ui.Image image) async {
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    }
    throw "The image could not be converted to png";
  }
}
