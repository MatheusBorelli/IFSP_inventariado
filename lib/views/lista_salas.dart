import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/salas.dart';
import 'package:ifsp_inventariado/utils/rest_api.dart';

import 'package:ifsp_inventariado/utils/styles.dart';

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
          backgroundColor: greenColor,
          elevation: 12,
          toolbarHeight: 70,
          title: const Text(
            style: TextStyle(fontSize: 30),
            'Salas'
          )
        )
      ),
      // floatingActionButton: FloatingActionButton.large(
      //   backgroundColor: Colors.green,
      //   elevation: 12,
      //   child: const Icon(Icons.add),
      //   onPressed: () {},
      // ),
      body: const _SalasInventarioWidget(),
    );
  }
}

class _SalasInventarioWidget extends StatefulWidget{
  const _SalasInventarioWidget({Key? key}): super(key: key);

  @override
  State<_SalasInventarioWidget> createState() {
    return _SalasInventarioState();
  }
}

class _SalasInventarioState extends State<_SalasInventarioWidget>{
  late Future<List<Sala>> futureSalas; 

  @override
  void initState(){
    super.initState();
    futureSalas = fetchSalasData();
  }

  Future<List<Sala>> fetchSalasData() async {
    final salasJson = await ClientREST().get('/salas');
    print(salasFromJson(salasJson));
    return salasFromJson(salasJson);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sala>>(future: futureSalas, builder: (context, snap){
        if(snap.hasData)
        {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snap.data?.length != null ? snap.data!.length : 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: SizedBox(
                  height: 80,
                  // width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/barreader' , arguments: snap.data![index]);
                    },
                    style: DefaultButton(null),
                    child: Text(
                      snap.data![index].nomeSala,
                      style: const TextStyle(color: Colors.black87, fontSize: 28),
                    )
                  )
                ),
              );
            },
          );
        } 
        else if(snap.hasError){
          return Text('${snap.error}');
        }
        return const Center(child: CircularProgressIndicator(color: greenColor,));
      }
    );
  }
}

