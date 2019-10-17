import 'package:flutter/material.dart';
import 'package:smart_shopping/operations/injection.dart';
import 'package:smart_shopping/operations/calculations.dart';

class CartItems extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() => _CartItems();
}


class _CartItems extends State<CartItems> {

  List<String> cartGet = [];
  Calculations cal = new Calculations();

    @override
    void initState() {
    setState(() {
      cartGet = Injections.cart;
    });
    }

    void delete(index){
      setState(() {
        cartGet.removeAt(index);
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
                        _buidList(context, cartGet, index),
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
                          Calculations.price = 0;
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




Widget _buidList(BuildContext context, List cart, index){


    
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(cart[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              delete(index);
            }
            
          ),
        )
      ],
    );
}
      

}