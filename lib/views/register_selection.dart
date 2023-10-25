import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/salas.dart';

import 'package:ifsp_inventariado/utils/styles.dart';

class RegisterSelection extends StatelessWidget {
  
  const RegisterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: ModalRoute.of(context)?.canPop == true ? 
          IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back), iconSize: 35,) : null,
          elevation: 12,
          toolbarHeight: 70,
          backgroundColor: greenColor,
          title: const Text(
            style: TextStyle(fontSize: 30),
            'Registros'
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
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.room_outlined, size: 50, color: Colors.black87,),
                  label: const Text('Registros de uma sala', style: TextStyle(fontSize: 32, color: Colors.black87)),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/salas', arguments: (
                      "/itemregister",
                      (false, true)
                    ));
                  },
                  style: DefaultButton(const Size(400, 400)),
                  ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: ElevatedButton.icon(
                  icon: const Icon(CupertinoIcons.barcode, size: 50, color: Colors.black87,),
                  label: const Text('Registros de um código', style: TextStyle(fontSize: 32, color: Colors.black87)),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/barreader', arguments: (
                      Sala(nomeSala: ''),
                      "/itemregister",
                      (false, false)
                    ));
                  },
                  style: DefaultButton(const Size(400, 400)),
                  ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}