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
  Map details = {};
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
  Map detailsKeys = {
    "barcode": "Barcode :",
    "brand": "Brand :",
    "price": "Price ",
    "expiryDate": "Expire date :",
  };

  renderWidget(QuerySnapshot qs) {
    if (qs.documents.length == 0) return Text('No item found for the barcode');

    List<Widget> rowWidgets = detailsKeys.keys
        .map(
          (k) => qs.documents[0].data[k] != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Text(detailsKeys[k])),
                    Expanded(
                      child: k != 'materials'
                          ? Text(qs.documents[0].data[k])
                          : Wrap(
                              children: qs.documents[0].data[k]
                                  .map<Widget>(
                                    (item) => Padding(
                                      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                      child: Chip(
                                        label: Text(item),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        )
        .toList();
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            qs.documents[0].data['itemName'] ?? "No Name",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: 20,
            width: double.infinity,
          ),
          Column(
            children: rowWidgets,
          ),
        ],
      ),
    );
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
    QuerySnapshot qs = await Firestore.instance
        .collection('items')
        .where('barcode', isEqualTo: barcode)
        .limit(1)
        .getDocuments();
    setState(() {
      detailsWidget = renderWidget(qs);
    });
    Navigator.pop(context);
  }

  onScan(context) async {
    try {
      String barcode =
          await FlutterBarcodeScanner.scanBarcode('#34eb7d', 'close', true);
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
      body: Container(
        child: Column(
          children: <Widget>[
            // Center(
            //   child: RaisedButton(
            //     child: Text("Set manually"),
            //     onPressed: () => onBarcode("725272730706",context),
            //     // onPressed: () => onBarcode("testing123", context),
            //   ),
            // ),
            detailsWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.scanner),
      ),
    );
  }
}