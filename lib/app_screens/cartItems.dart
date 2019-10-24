import 'package:flutter/material.dart';
import 'package:smart_shopping/operations/injection.dart';
import 'package:smart_shopping/operations/calculations.dart';
import 'package:smart_shopping/app_screens/home.dart';

class CartItems extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() => _CartItems();
}


class _CartItems extends State<CartItems> {

  List<String> cartGet = [];
  List<int> priceGet = [];
  List<int> quantityGet = [];
  int price = 0;
  int total = 0;
  Calculations cal = new Calculations();
  Home val = new Home();

    @override
    void initState() {
    setState(() {
      cartGet = Injections.cart;
      priceGet = Injections.priceList;
      quantityGet = Injections.quantityList;
    });
    }

    void delete(index){
      setState(() {
        cartGet.removeAt(index);
        priceGet.removeAt(index);
        quantityGet.removeAt(index);
      });
    }

    void clear(){
      setState(() {
        cartGet.clear();
        priceGet.clear();
        quantityGet.clear();
        Calculations.finalPrice.clear();
        Calculations.temp1 = 2;
      });
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Cart"),
      ),
      body: ListView.builder(
                      itemExtent: 80.0,
                      itemCount: Injections.cart.length,
                      itemBuilder: (context, index) =>
                        _buidList(context, cartGet, priceGet, quantityGet, index),
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




Widget _buidList(BuildContext context, List cart, List priceE, List quantityGet, index){


    
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Text(quantityGet[index].toString()),
          title: Text(cart[index]),
          subtitle: Text(priceE[index].toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              Calculations.reducePrice = priceGet[index] * quantityGet[index];
              Calculations.temp1 = 1;
              delete(index);
            }
            
          ),
        )
      ],
    );
}
      

}