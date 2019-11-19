import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_shopping/operations/injection2.dart';
import 'package:smart_shopping/operations/calculations2.dart';

class Billing extends StatefulWidget {
  @override
  _Billing createState() => _Billing();
}

class _Billing extends State<Billing> {
  var barcode = '';
  DocumentSnapshot qs;
  List<String> brandGet = [];
  List<int> priceGet = [];
  List<int> quantityGet = [];
  String q;
  int finalPrice;
  Calculations2 cal = new Calculations2();

   @override
    void initState() {
    setState(() {
      brandGet = Injections2.brandList;
      priceGet = Injections2.priceList;
      quantityGet = Injections2.quantityList;
    });
    }

   void delete(index){
      setState(() {
        brandGet.removeAt(index);
        priceGet.removeAt(index);
        quantityGet.removeAt(index);
      });
    }

    void clear(){
      setState(() {
        brandGet.clear();
        priceGet.clear();
        quantityGet.clear();
        Calculations2.finalPrice.clear();
        Calculations2.temp1 = 2;
      });
    }

    setValue(String brand,int price){
       
   Injections2.brandList.add(brand);
   Injections2.priceList.add(price);
   Injections2.quantityList.add(int.parse(q));
   finalPrice = price * int.parse(q);
   Calculations2.finalPrice.add(finalPrice);
 }


    
  onBarcode(barcode, context) async {
    qs = await Firestore.instance
        .collection('Barcode_details')
        .document(barcode).get();
    
    // showDialog(
    //   builder: (context) => Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       CircularProgressIndicator(),
    //     ],
    //   ),
    //   context: context,
    //   barrierDismissible: false,
    // );
    addToList(qs);
    print(barcode);
    
  }
   void _showDialog(context, qs) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Text(qs.data['brand']),
          content:  TextField(            
            onChanged: (value) => q = value,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child:  Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             FlatButton(
              child: Text("Add"),
              onPressed: () {
                // print(brand);
                // Injections2.quantityList.add(int.parse(q));
                // Injections2.brandList.add(qs.data["brand"]);
                // Injections2.priceList.add(qs.data["price"]);
                setValue(qs.data['brand'], qs.data['price']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  addToList(qs){
    if(qs != null){
      print(qs.data['brand']);
      _showDialog(context, qs);
    }else{
      print("error");
    }
  }

  onScan(context) async {
    try {
      String barcode = '123';
      // await FlutterBarcodeScanner.scanBarcode('#34eb7d', 'close', true);
      setState(() {
        this.barcode = 'barcode';
      });
      onBarcode(barcode, context);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan here'),
      ),
      body: ListView.builder(
                      itemExtent: 80.0,
                      itemCount: Injections2.brandList.length,
                      itemBuilder: (context, index) =>
                        _buidList(context, priceGet, brandGet, quantityGet, index),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.scanner),
      ),
       bottomSheet: Container(
        height: 100,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Total",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        )
                      ),
                  Expanded(child: TextFormField(
                    readOnly: true,
                    initialValue: cal.genarateTotal().toString(),
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                  ))),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right:50.0,left:50.0),
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text("Pay",style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {},),
                    )
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right:50.0,left:50.0),
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          clear();
                        },),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



Widget _buidList(BuildContext context, List price, List brand, List quant, index){
   
    return ListView(
      children: <Widget>[
        ListTile(
          // leading: Text(quantityGet[index].toString()),
          leading: Text(quant[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
          title: Text(brand[index]),
          subtitle: Text(price[index].toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              Calculations2.reducePrice = price[index] * quant[index];
              Calculations2.temp1 = 1;
              delete(index);
            }
            
          ),
        )
      ],
    );
}
}