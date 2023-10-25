import 'package:flutter/material.dart';

import 'package:ifsp_inventariado/utils/rest_api.dart';
import 'package:ifsp_inventariado/utils/styles.dart';

import 'package:ifsp_inventariado/models/register.dart';
import 'package:ifsp_inventariado/views/lista_salas.dart';

import 'package:intl/intl.dart';


class ProductRegister extends StatelessWidget {
  final String data;
  final bool search;
  final bool visibleAddButton;

  const ProductRegister({super.key, required this.data, this.visibleAddButton = true, this.search = false});

  @override
  Widget build(context){
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar:
          PreferredSize(preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            leading: ModalRoute.of(context)?.canPop == true ? 
            IconButton(onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), icon: const Icon(Icons.home_outlined), iconSize: 35,) : null,
            backgroundColor: greenColor,
            elevation: 12,
            centerTitle: true,
            toolbarHeight: 70,
            title: const Text(
              style: TextStyle(fontSize: 30),
              'Registro'
            ),
            
            actions: [
              Visibility(
                visible: visibleAddButton,
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (builder) => const ListaSalas()),
                      (route) => route.isFirst);
                    }, 
                    icon: const Icon(Icons.add), 
                    iconSize: 35,
                    color: Colors.black87),
                ),
              ),
            ],
          )
        ),
        body: _ProductRegisterWidget(dataToFetchRegister: data, itemOrRoomSearch: search),
      ),
    );
  }
}

class _ProductRegisterWidget extends StatefulWidget{
  final String dataToFetchRegister;
  
  ///Defaults to item(false) so it makes the search for registers by item, setting to true will change to search by room
  final bool itemOrRoomSearch;

  const _ProductRegisterWidget({Key? key, required this.dataToFetchRegister, this.itemOrRoomSearch = false}): super(key: key);
  
  @override
  State<_ProductRegisterWidget> createState() {
    return _ProductRegisterState();
  }
}

class _ProductRegisterState extends State<_ProductRegisterWidget>{
  late Future<dynamic> futureRegisters; 

  @override
  void initState() {
    super.initState();
    futureRegisters = fetchRegisterData();
  }

  Future<dynamic> fetchRegisterData() async {
    final String getApiRoute = widget.itemOrRoomSearch ? '/room_register' : '/product_register'; 

    final dataRegisterJson = await ClientREST().get('$getApiRoute/${widget.dataToFetchRegister}');
    
    if(dataRegisterJson.toString().contains('Erro')) return dataRegisterJson.toString();
    
    final listRegisters = registerListFromJson(dataRegisterJson);
    listRegisters.sort(((a, b) => 
      DateTime.parse(b.data).compareTo(DateTime.parse(a.data))
    ));
    return listRegisters;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(future: futureRegisters, builder: (context, snap){
        if(snap.hasData)
        {
          if(snap.data.toString().contains("Erro")){ 
            return const ErrorWidget();
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snap.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  color: snap.data?[index].salaRegistro == snap.data?[index].item.sala ? Colors.green.shade200 : Colors.red.shade200,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.center,

                  child: Column(
                    children: [
                      Text(
                        "Item: ${snap.data?[index].item.itemNome} - Código: ${snap.data?[index].item.itemBarcode}",
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      Text(
                        "Local de Origem: ${snap.data?[index].item.sala}",
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      Text(
                        "Ultimo registro na sala: ${snap.data?[index].salaRegistro}",
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      Text(
                        "Registrado em ${DateFormat('dd/MM/yyyy - hh:mm').format(DateTime.parse(snap.data![index].data))}",
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ],
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

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Container build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: const Text(
        "O Item ou sala não foi encontrado ou não há registros",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
    );
  }
}

