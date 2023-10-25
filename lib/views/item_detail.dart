import 'package:flutter/material.dart';

import 'package:ifsp_inventariado/models/item.dart';

import 'package:ifsp_inventariado/utils/styles.dart';
import 'package:ifsp_inventariado/utils/rest_api.dart';

class ItemDetail extends StatelessWidget{
  final Item data;

  const ItemDetail({Key? key, required this.data}): super(key: key);

  @override
  Widget build(context){
    return Scaffold(appBar:
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
            'Item'
          )
        )
      ),
      body: _ItemDetail(itemData: data),
    );
  }
}

class _ItemDetail extends StatefulWidget{
  final Item itemData;

  const _ItemDetail({Key? key, required this.itemData}): super(key: key);

  @override
  State<_ItemDetail> createState(){
    return _ItemDetailState();
  }
}

class _ItemDetailState extends State<_ItemDetail>{
  late Future<dynamic> futureItem;

  TextEditingController nameTextField = TextEditingController(text: ""); 

  @override
  void initState(){
    super.initState();
    futureItem = fetchItemData();
  }

  Future<dynamic> fetchItemData() async {
    // final Item itemJson;
    final data = await ClientREST().get('/item/${widget.itemData.itemBarcode}');
    if(!data.toString().contains("Erro")){
      final item = itemFromJson(data.toString());
      setState(() {
        nameTextField.text = item.itemNome;
      });
      return item; 
    }
    return data.toString();
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<dynamic>(future: futureItem, builder: (context, snap) {
      if(snap.hasData) {
        if(!snap.data.toString().contains("Erro")){
          return _registerItem(snap);
        }
        return _addItem();
      } 
      else if(snap.hasError) {
        Navigator.of(context).pushNamed("/error", arguments: snap.error);
      }

      return const Center(child: CircularProgressIndicator(color: greenColor,));
    });
  }

  Scaffold _registerItem(AsyncSnapshot<dynamic> snap) {
    bool _visible = true;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 30),
            child: Text(
              "Registrar Item:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24
              )
              ),
          ),
        
          Row(children: [
            const SizedBox(
              width: 160,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Nome do item:",
                  style: TextStyle(fontSize: 18)
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: TextField(
                    enabled: false,
                    
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,        
                      isDense: true,
                      hintText: snap.data.itemNome,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]
          ),
          
          Row(children: [  
            const SizedBox(
              width: 160,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Código:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18)
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: TextField(
                  enabled: false,
                  textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,        
                      isDense: true,
                      hintText: snap.data.itemBarcode,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]
          ),
          
          Row(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(
                width: 160,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Sala do item:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18
                    ),
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: TextField(
                    enabled: false, 
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,        
                      isDense: true,
                      hintText: snap.data.sala,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]),

          Row(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(
                width: 160,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Sala do registro:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18
                    ),
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: TextField(
                    enabled: false, 
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,        
                      isDense: true,
                      hintText: widget.itemData.sala,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _visible,
        child: FloatingActionButton(
          backgroundColor: greenColor,
          shape: const CircleBorder(),
          elevation: 8,
          onPressed: () async {
            setState(() => _visible = false);
            final response = await ClientREST().post(
              '/add_register/', 
              Item(
                itemNome: snap.data!.itemNome,
                itemBarcode: widget.itemData.itemBarcode,
                sala: widget.itemData.sala,)
            );
            if(!context.mounted) return;
            if( response == 201 || response == 200 ){
              Navigator.of(context).pushNamed(
                '/itemregister',
                arguments: snap.data.itemBarcode
              );
            }
            else{
              Navigator.of(context).pushNamed( 
                "/error/$response",
                arguments: "Status Code: $response");
            }
          },
          child: const Icon(Icons.check_sharp, size: 50,),
        ),
      ),
    );
  }

  Scaffold _addItem() {
    bool _visible = true;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 30),
            child: Text(
              "Adicionar Item:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24
              )
              ),
          ),
        
          Row(children: [
            const SizedBox(
              width: 160,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Nome do item:",
                  style: TextStyle(fontSize: 18)
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: TextField(
                    enabled: true,
                    controller: nameTextField,
                    autofocus: true,

                    cursorColor: Colors.black87,
                    textAlign: TextAlign.center,
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
                      
                      hintText: widget.itemData.itemNome,
                  ),
                ),
              ),
            )
          ]),
          
          Row(children: [  
            const SizedBox(
              width: 160,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Código:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18)
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,

                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,        
                      isDense: true,
                      hintText: widget.itemData.itemBarcode,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]
          ),
          
          Row(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(
                width: 160,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Sala do item:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18
                    ),
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.black87
                        )
                      ),
                      filled: true,
                      fillColor: greyColor,
                      focusColor: Colors.black87,
                      isDense: true,
                      hintText: widget.itemData.sala,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      )
                    ),
                  ),
                ),
              )
            ]),
        ],
      ),

      floatingActionButton: Visibility(
        visible: _visible,
        child: FloatingActionButton(
          backgroundColor: greenColor,
          shape: const CircleBorder(),
          elevation: 8,
          onPressed: () async {
            final createResponse = await ClientREST().post(
              '/add_item/', 
              Item(
                itemNome: nameTextField.text,
                itemBarcode: widget.itemData.itemBarcode,
                sala: widget.itemData.sala,)
            );
            if(!context.mounted) return;
            if( createResponse == 201 || createResponse == 200 ){
              final registerResponse = await ClientREST().post(
                '/add_register/', 
                Item(
                  itemNome: nameTextField.text,
                  itemBarcode: widget.itemData.itemBarcode,
                  sala: widget.itemData.sala,));
              if(!context.mounted) return;
              if( registerResponse == 201 || registerResponse == 200){
                Navigator.of(context).pushNamed(
                  '/itemregister',
                  arguments: widget.itemData.itemBarcode
                );
              }
              else{
                Navigator.of(context).pushNamed( 
                "/error/$registerResponse",
                arguments: "Status Code: $registerResponse");
              }
            }
            else{
              Navigator.of(context).pushNamed( 
                "/error/$createResponse",
                arguments: "Status Code: $createResponse");
            }
          },
          child: const Icon(Icons.check_sharp, size: 50,),
        ),
      ),
    );
  }
}