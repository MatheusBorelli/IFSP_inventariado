import 'package:flutter/material.dart';

class ListaSalas extends StatelessWidget {
  const ListaSalas({super.key});

  @override
  Widget build(context){
    return Scaffold(
      appBar:
        PreferredSize(preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: ModalRoute.of(context)?.canPop == true ? 
          IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back), iconSize: 35,) : null,
          elevation: 12,
          toolbarHeight: 70,
          title: const Text(
            style: TextStyle(fontSize: 30),
            'Salas'
          )
        )
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.green,
        elevation: 12,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: const _SalasInventarioWidget(),
    );
  }
}

class _SalasInventarioWidget extends StatefulWidget{
  const _SalasInventarioWidget({super.key});

  @override
  State<_SalasInventarioWidget> createState() {
    return _SalasInventarioState();
  }
}

class _SalasInventarioState extends State<_SalasInventarioWidget>{
  
  final defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade300,
    foregroundColor: const Color.fromARGB(255, 27, 221, 44),
    elevation: 2,
    fixedSize: const Size(240, 60),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    textStyle: const TextStyle(fontSize: 18),
  );
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: SizedBox(
            height: 80,
            // width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {},
              style: defaultButtonStyle,
              child: const Text(
                'A100',
                style: TextStyle(color: Colors.black87, fontSize: 28),
              )
            )
          ),
        );
      },
    );
  }
}

