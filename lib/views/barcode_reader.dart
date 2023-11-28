import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ifsp_inventariado/utils/styles.dart';

import 'package:ifsp_inventariado/models/item.dart';
import 'package:ifsp_inventariado/models/salas.dart';

class BarCodePage extends StatefulWidget {
  final Sala data;
  final String _nextRoute;
  final (bool, bool)? nextRouteArgument;

  const BarCodePage({super.key, required this.data, String nextRoute = '/itemdetail', this.nextRouteArgument}) : _nextRoute = nextRoute;
  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String barcode = '';
  TextEditingController barcodeTextField = TextEditingController(text: "");

  Future readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.BARCODE,
    );
    setState(() {
      barcode = code != '-1' ? code : '';
      barcodeTextField.text = barcode;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: ModalRoute.of(context)?.canPop == true ? 
          IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back), iconSize: 35,) : null,
          elevation: 12,
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: greenColor,
          title: const Text(
            style: TextStyle(fontSize: 30),
            'Ler Código'
          )
        )
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: ElevatedButton.icon(
                  icon: const Icon(CupertinoIcons.barcode, size: 50, color: Colors.black87,),
                  label: const Text('Ler Código', style: TextStyle(fontSize: 36, color: Colors.black87)),
                  onPressed: () async {
                    readQRCode();
                  },
                  style: DefaultButton(const Size(400, 400)),
                  ),
              ),
            ),
            
            const SizedBox(height: 30),
            const Text('OU',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
              child: TextField(
                controller: barcodeTextField,
                autofocus: true,
                autocorrect: false,

                cursorHeight: 40,
                cursorWidth: 3,
                cursorColor: Colors.black87,
                
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                ),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.black87
                    )
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3
                    )
                  ),
                  
                  filled: true,
                  fillColor: greyColor,
                  
                  focusColor: Colors.black87,

                  isDense: true,
                  
                  hintText: "Digite o código"
                ),
              ),
            ),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: greenColor,
        shape: const CircleBorder(),
        elevation: 8,
        child: const Icon(Icons.check_sharp, size: 50,),
        onPressed: () {
          barcode = barcodeTextField.text;
          Navigator.of(context).pushNamed(
            widget._nextRoute, 
            arguments: widget.nextRouteArgument == null ? Item(
              sala: widget.data.nomeSala,
              itemBarcode: barcode
            ) : 
            (
              barcode,
              widget.nextRouteArgument!.$1,
              widget.nextRouteArgument!.$2
            )
          );
        },
      ),
    );
  }
}