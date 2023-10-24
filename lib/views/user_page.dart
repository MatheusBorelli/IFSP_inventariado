import 'package:flutter/material.dart';

import 'package:ifsp_inventariado/utils/styles.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  // final defaultButtonStyle = const ButtonStyle(
  //   backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 223, 223, 223)),
  // );
  
  void doNothing(){}

  @override
  Widget build(context){
    return Scaffold(
      body: Column( children: [
              Stack(
                alignment: Alignment.bottomCenter, 
                children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Image.asset(
                          'assets/ifsp_banner.jpg',
                          fit: BoxFit.fitWidth,
                      ),
                    ),
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                        ),
                        child: Image.asset(
                          'assets/ifsp_logo.jpg', 
                          height: 100, 
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text('Inventario:', style: TextStyle(fontSize: 24),),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/salas');
                        },
                        style: DefaultButton(null),
                        child: const Text(
                          'Registrar Invetário',
                          style: TextStyle(color: Colors.black87),
                        )
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: doNothing,
                        style: DefaultButton(null),
                        child: const Text(
                          'Registros',
                          style: TextStyle(color: Colors.black87),
                        )
                      ),
                    ]
                  ),  
          ],
      ),
    );
  }
}