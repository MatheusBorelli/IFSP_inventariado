import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/salas.dart';
import 'package:ifsp_inventariado/utils/rest_api.dart';

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
  const _SalasInventarioWidget({super.key});

  @override
  State<_SalasInventarioWidget> createState() {
    return _SalasInventarioState();
  }
}

class _SalasInventarioState extends State<_SalasInventarioWidget>{
  
  final defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade300,
    foregroundColor: Colors.black,
    elevation: 2,
    fixedSize: const Size(240, 60),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    textStyle: const TextStyle(fontSize: 18),
  );
  
  late Future<List<Salas>> futureSalas; 

  @override
  void initState(){
    super.initState();
    futureSalas = fetchSalasData();
  }

  Future<List<Salas>> fetchSalasData() async {
    final salasJson = await ClientREST().get('/test');
    return salasFromJson(salasJson);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Salas>>(future: futureSalas, builder: (context, snap){
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
                      Navigator.of(context).pushNamed('/bar_reader');
                    },
                    style: defaultButtonStyle,
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
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

