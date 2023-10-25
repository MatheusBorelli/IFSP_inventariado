import 'package:flutter/material.dart';
import 'package:ifsp_inventariado/models/salas.dart';
import 'package:ifsp_inventariado/utils/rest_api.dart';

import 'package:ifsp_inventariado/utils/styles.dart';

class ListaSalas extends StatelessWidget {
  final String _nextRoute;
  final (bool , bool)? nextRouteArgument;

  const ListaSalas({super.key, String nextRoute = '/barreader', this.nextRouteArgument}) : _nextRoute = nextRoute;

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
          centerTitle: true,
          toolbarHeight: 70,
          title: const Text(
            style: TextStyle(fontSize: 30),
            'Salas'
          )
        )
      ),
      body: _SalasInventarioWidget(nextRoute: _nextRoute, nextRouteArgument: nextRouteArgument),
    );
  }
}

class _SalasInventarioWidget extends StatefulWidget{
  final String nextRoute;
  final (bool, bool)? nextRouteArgument;
  
  const _SalasInventarioWidget({super.key , this.nextRoute = '/barreader', this.nextRouteArgument});

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
                      Navigator.of(context).pushNamed( widget.nextRoute , 
                      arguments: widget.nextRouteArgument == null ?
                        snap.data![index] : 
                        (
                          snap.data![index].nomeSala,
                          widget.nextRouteArgument!.$1,
                          widget.nextRouteArgument!.$2,
                        )
                      );
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

