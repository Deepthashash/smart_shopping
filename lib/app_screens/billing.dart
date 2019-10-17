import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Billing extends StatefulWidget {
  @override
  _Billing createState() => _Billing();
}

class _Billing extends State<Billing> {
  var barcode = '';
  DocumentSnapshot qs;
  Widget detailsWidget = Expanded(
    child:ListView(
      children: <Widget>[
        ListTile(
          title: Text("Rs: 55.00"),
          leading: Text("Bread"),
          trailing: IconButton(
            icon: Icon(Icons.close),
             onPressed: () {},
        ),
        ),
        ListTile(
          title: Text("Rs: 55.00"),
          leading: Text("Bread"),
          trailing: IconButton(
            icon: Icon(Icons.close),
             onPressed: () {},
        ),
        ),
        ListTile(
          title: Text("Rs: 55.00"),
          leading: Text("Bread"),
          trailing: IconButton(
            icon: Icon(Icons.close),
             onPressed: () {},
        ),
        ), 
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              onPressed: null,
              child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.check),
                    Text("Accept")
                  ],
                ),
            ),
            RaisedButton(
              onPressed: null,
              child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.cancel),
                    Text("Cancel")
                  ],
                ),
            ),
          ],
        ) 
      ],
    ),
  );
 

  
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
      body: _barData(qs),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.scanner),
      ),
    );
  }
}

  Widget _barData(qs) {
    if (qs != null) {
      return ListView(
        children: <Widget>[
            Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text(qs.data["brand"]),
                subtitle: Text("Rs." + qs.data["price"].toString()),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                  },
                ),
              )),
            ],
          ),
          
        ],
      );
    } else {
      return (Center(child: Text("No Data!!")));
    }
  }

