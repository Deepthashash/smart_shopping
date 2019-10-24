import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_shopping/operations/injection2.dart';

class Billing extends StatefulWidget {
  @override
  _Billing createState() => _Billing();
}

class _Billing extends State<Billing> {
  var barcode = '';
  DocumentSnapshot qs;
  List<String> brandGet = [];
  List<int> priceGet = [];

   @override
    void initState() {
    setState(() {
      brandGet = Injections2.brandList;
      priceGet = Injections2.priceList;
    });
    }

    
  onBarcode(barcode, context) async {
    showDialog(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
      context: context,
      barrierDismissible: false,
    );
    qs = await Firestore.instance
        .collection('Barcode_details')
        .document(barcode).get();
    
  }

  addToList(qs){
    if(qs != null){
      Injections2.brandList.add(qs.data["brand"]);
      Injections2.priceList.add(qs.data["price"]);
    }
  }

  onScan(context) async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode('#34eb7d', 'close', true);
      setState(() {
        this.barcode = barcode;
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
                        _buidList(context, priceGet, brandGet, index),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.scanner),
      ),
    );
  }
}


Widget _buidList(BuildContext context, List price, List brand, index){
   
    return ListView(
      children: <Widget>[
        ListTile(
          // leading: Text(quantityGet[index].toString()),
          title: Text(brand[index]),
          subtitle: Text(price[index].toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              // Calculations.reducePrice = priceGet[index] * quantityGet[index];
              // Calculations.temp1 = 1;
              // delete(index);
            }
            
          ),
        )
      ],
    );
}
