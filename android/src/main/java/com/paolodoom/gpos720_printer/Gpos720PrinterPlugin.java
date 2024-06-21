package com.paolodoom.gpos720_printer;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;
import java.io.ByteArrayInputStream;

/**
 * Gpos720PrinterPlugin
 */
public class Gpos720PrinterPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private GertecPrinter gertecPrinter;
    private ConfigPrint configPrint = new ConfigPrint();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "gpos720_printer");
        channel.setMethodCallHandler(this);
        Context context = flutterPluginBinding.getApplicationContext();
        gertecPrinter = new GertecPrinter(context);
        gertecPrinter.setConfigImpressao(configPrint);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        configPrint = new ConfigPrint();
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "checarImpressora":
                try {
                    result.success("" + gertecPrinter.getStatusImpressoraEnum().getValue());
                } catch (Exception e) {
                    Log.e("Gpos720_printer", "checarImpressora: " + e.getMessage(), e);
                    result.error("Erro no método \"checarImpressora\"", e.getLocalizedMessage(), e);
                }
                break;
            case "fimImpressao":
                try {
                    gertecPrinter.impressoraOutput();
                    result.success("" + gertecPrinter.getStatusImpressoraEnum().getValue());
                } catch (Exception e) {
                    Log.e("Gpos720_printer", "fimImpressao: " + e.getMessage(), e);
                    result.error("Erro no método \"fimImpressao\"", e.getLocalizedMessage(), e);
                }
                break;
            case "avancaLinha":
                try {
                    gertecPrinter.avancaLinha(call.argument("quantLinhas"));
                    result.success("" + gertecPrinter.getStatusImpressoraEnum().getValue());
                } catch (Exception e) {
                    Log.e("Gpos720_printer", "avancaLinha: " + e.getMessage(), e);
                    result.error("Erro no método \"avancaLinha\"", e.getLocalizedMessage(), e);
                }
                break;
            case "imprimir":
                try {
                    gertecPrinter.getStatusImpressoraEnum();
                    if (gertecPrinter.isImpressoraOK()) {
                        String tipoImpressao = call.argument("tipoImpressao");
                        switch (tipoImpressao) {
                            case "Texto":
                                List<Boolean> options = call.argument("options");
                                configPrint.setItalico(options.get(1));
                                configPrint.setSublinhado(options.get(2));
                                System.out.println(call.argument("size").toString());
                                configPrint.setNegrito(options.get(0));
                                System.out.println(call.argument("font").toString());
                                configPrint.setTamanho(call.argument("size"));
                                configPrint.setFonte(call.argument("font"));
                                configPrint.setAlinhamento(call.argument("align"));
                                gertecPrinter.setConfigImpressao(configPrint);
                                gertecPrinter.imprimeTexto(call.argument("mensagem"));
                                break;
                            case "Imagem":
                                byte[] dataImage0 = (byte[]) call.argument("data");
                                Bitmap image0 = byteArrayToBitmap(dataImage0);
                                configPrint.setAlinhamento(call.argument("align"));
                                configPrint.setiWidth(call.argument("width"));
                                configPrint.setiHeight(call.argument("height"));
                                gertecPrinter.setConfigImpressao(configPrint);
                                gertecPrinter.imprimeImagem(image0);
                                break;
                            case "CodigoDeBarra":
                                configPrint.setAlinhamento("CENTER");
                                gertecPrinter.setConfigImpressao(configPrint);
                                gertecPrinter.imprimeBarCodeIMG(call.argument("mensagem"), call.argument("height"),
                                        call.argument("width"), call.argument("barCode"));
                                break;
                            case "CodigoDeBarraImg":
                                configPrint.setAlinhamento("CENTER");
                                gertecPrinter.setConfigImpressao(configPrint);
                                gertecPrinter.imprimeBarCodeIMG(call.argument("mensagem"), call.argument("height"),
                                        call.argument("width"), call.argument("barCode"));
                            case "TodasFuncoes":
                                byte[] dataImage1 = (byte[]) call.argument("data");
                                Bitmap image1 = byteArrayToBitmap(dataImage1);
                                imprimeTodasAsFucoes(image1, call.argument("width"), call.argument("height"));
                                break;
                        }
                        result.success("" + gertecPrinter.getStatusImpressoraEnum().getValue());
                    } else {
                        throw new Exception("isImpressoraOK = " + gertecPrinter.isImpressoraOK());
                    }
                } catch (Exception e) {
                    Log.e("Gpos720_printer", "imprimir: " + e.getMessage(), e);
                    result.error("Erro no método \"imprimir\"", e.getLocalizedMessage(), e);
                }
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private void imprimeTodasAsFucoes(Bitmap bmp, int width, int height) throws Exception {
        configPrint.setItalico(false);
        configPrint.setNegrito(true);
        configPrint.setTamanho(20);
        configPrint.setFonte("MONOSPACE");
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.getStatusImpressoraEnum();
        // Imprimindo Imagem
        configPrint.setiWidth(width);
        configPrint.setiHeight(height);
        configPrint.setAlinhamento("CENTER");
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("==[Iniciando Impressao Imagem]==");
        gertecPrinter.imprimeImagem(bmp);
        gertecPrinter.avancaLinha(10);
        gertecPrinter.imprimeTexto("====[Fim Impressão Imagem]====");
        gertecPrinter.avancaLinha(10);
        // Fim Imagem

        // Impressão Centralizada
        configPrint.setAlinhamento("CENTER");
        configPrint.setTamanho(30);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("CENTRALIZADO");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Centralizada

        // Impressão Esquerda
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(40);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("ESQUERDA");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Esquerda

        // Impressão Direita
        configPrint.setAlinhamento("RIGHT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("DIREITA");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Direita

        // Impressão Negrito
        configPrint.setNegrito(true);
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("=======[Escrita Netrigo]=======");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Negrito

        // Impressão Italico
        configPrint.setNegrito(false);
        configPrint.setItalico(true);
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("=======[Escrita Italico]=======");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Italico

        // Impressão Italico
        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(true);
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("======[Escrita Sublinhado]=====");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Italico

        // Impressão BarCode 128
        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(false);
        configPrint.setAlinhamento("CENTER");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("====[Codigo Barras CODE 128]====");
        gertecPrinter.imprimeBarCode("12345678901234567890", 120, 120, "CODE_128");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão BarCode 128

        // Impressão Normal
        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(true);
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("=======[Escrita Normal]=======");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Normal

        // Impressão Normal
        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(true);
        configPrint.setAlinhamento("LEFT");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("=========[BlankLine 50]=========");
        gertecPrinter.avancaLinha(50);
        gertecPrinter.imprimeTexto("=======[Fim BlankLine 50]=======");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão Normal

        // Impressão BarCode 13
        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(false);
        configPrint.setAlinhamento("CENTER");
        configPrint.setTamanho(20);
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("=====[Codigo Barras EAN13]=====");
        gertecPrinter.imprimeBarCode("7891234567895", 120, 120, "EAN_13");
        gertecPrinter.avancaLinha(10);
        // Fim Impressão BarCode 128

        // Impressão BarCode 13
        gertecPrinter.setConfigImpressao(configPrint);
        gertecPrinter.imprimeTexto("===[Codigo QrCode Gertec LIB]==");
        gertecPrinter.avancaLinha(10);
        gertecPrinter.imprimeBarCode("Gertec Developer Partner LIB", 240, 240, "QR_CODE");

        configPrint.setNegrito(false);
        configPrint.setItalico(false);
        configPrint.setSublinhado(false);
        configPrint.setAlinhamento("CENTER");
        configPrint.setTamanho(20);
        gertecPrinter.imprimeTexto("===[Codigo QrCode Gertec IMG]==");
        gertecPrinter.imprimeBarCodeIMG("Gertec Developer Partner IMG", 240, 240, "QR_CODE");

        gertecPrinter.avancaLinha(40);
    }

    public Bitmap byteArrayToBitmap(byte[] byteArray) {
        ByteArrayInputStream inputStream = new ByteArrayInputStream(byteArray);
        return BitmapFactory.decodeStream(inputStream);
    }
}
