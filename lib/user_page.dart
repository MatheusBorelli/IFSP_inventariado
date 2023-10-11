import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  // final defaultButtonStyle = const ButtonStyle(
  //   backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 223, 223, 223)),
  // );
  final defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade300,
    foregroundColor: const Color.fromARGB(255, 27, 221, 44),
    elevation: 0,
    fixedSize: const Size(240, 60),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    textStyle: const TextStyle(fontSize: 18),
  );
  
  void DoNothing(){}

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
                const Text('Inventario'),
                Column(
                    children: [
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/salas');
                        },
                        style: defaultButtonStyle,
                        child: const Text(
                          'Registrar Invetário',
                          style: TextStyle(color: Colors.black87),
                        )
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: DoNothing,
                        style: defaultButtonStyle,
                        child: const Text(
                          'Registros',
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        )
                      ),
                    ]
                  ),  
          ],
      ),
    );
  }
}