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
    if(data is Item){
      setState(() {
        nameTextField.text = data.itemNome;
      });
      return itemFromJson(data.toString()); 
    }
    return data.toString();
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<dynamic>(future: futureItem, builder: (context, snap) {
      if(snap.hasData) {
        //Design goes here
        //TO-DO: Make and Design this part
        if(snap.data is String){
          print(snap.data);
          //return _AddItemFallBack(widgetData: widget.itemData);
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Registrar Item:", textAlign: TextAlign.left),
            ),
          
            Flexible(
              child: Row(children: [
                const Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Nome do item:",
                      style: TextStyle(fontSize: 18)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: TextField(
                        enabled: false,
                        controller: nameTextField,
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
                        
                        hintText: itemFromJson(snap.data.toString()).itemNome,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            
            Flexible(
              // height: 40,
              child: Row(children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Código:"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    enabled: false,
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
                    
                    
                    hintText: widget.itemData.itemBarcode,),
                  ),
                )
              ]),
            ),
            SizedBox(height: 30),
            
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 70,
                      child: Text("Sala:")),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                    child: TextField(
                      enabled: false, 
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        
                        
                        hintText: widget.itemData.sala,
                      ),
                    ),
                  ),
                )
              ]),
          
          ],
        );
      } 
      else if(snap.hasError) {
        Navigator.of(context).pushNamed("/error", arguments: snap.error);
      }
      return const Center(child: CircularProgressIndicator(color: greenColor,));
    });
  }
}
class _AddItemFallBack extends StatelessWidget {
  final Item widgetData;
  final dynamic data;

  const _AddItemFallBack({Key? key, this.data, required this.widgetData}): super(key: key);

  @override
  Widget build(context){
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("Registrar Item:", textAlign: TextAlign.left,),
        ),
        Row(children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Nome do item:"),
            ),
          ),
          Expanded(
            child: TextField(enabled: true, decoration: InputDecoration(
              hintText: "",
            ),),
          )
        ]),
        
        // Row(children: [
        //   const Padding(
        //     padding: EdgeInsets.only(left: 8.0),
        //     child: Text("Código:"),
        //   ),
        //   TextField(enabled: false, decoration: InputDecoration(
        //     hintText: widgetData.itemBarcode,
        //   ),)
        // ]),

        // Row(children: [
        //   const Padding(
        //     padding: EdgeInsets.only(left: 8.0),
        //     child: Text("Sala:"),
        //   ),
        //   TextField(enabled: false, decoration: InputDecoration(
        //     hintText: widgetData.sala,
        //   ),)
        // ]),
      ],
    );
  }
}