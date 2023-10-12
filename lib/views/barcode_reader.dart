import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String barcode = '';
  // List<String> tickets = [];

  Future readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.BARCODE,
    );
    setState(() => barcode = code != '-1' ? code : 'Não validado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (barcode != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Código: $barcode',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ElevatedButton.icon(
              icon: const Icon(CupertinoIcons.barcode, size: 40,),
              label: const Text('Validar', style: TextStyle(fontSize: 28),),
              onPressed: () async {
                readQRCode();
              },
            ),
          ],
        ),
      ),
    );
  }
}